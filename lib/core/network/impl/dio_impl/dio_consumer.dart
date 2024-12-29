import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../abstract/api_consumer.dart';
import '../../constants/constants.dart';
import '../../constants/endpoinst.dart';
import 'dio_interceptors.dart';

class DioConsumer extends ApiConsumer {
  final Dio client;
  final DioInterceptor dioInterceptor;
  final LogInterceptor logInterceptor;

  DioConsumer({
    required this.client,
    required this.dioInterceptor,
    required this.logInterceptor,
  }) {
    dioInit();
  }

  void dioInit() {
    client.options = BaseOptions(
      responseType: ResponseType.plain,
      followRedirects: false,
      headers: {"accept": "application/json"},
      receiveDataWhenStatusError: true,
      sendTimeout: ApiConstants.sendTimeOut,
      connectTimeout: ApiConstants.connectTimeOut,
      receiveTimeout: ApiConstants.receiveTimeOut,
      baseUrl: EndPoints.baseUrl,
    );

    client.interceptors.add(dioInterceptor);

    //! Use log interceptor only in debug mode
    if (kDebugMode) {
      client.interceptors.add(logInterceptor);
    }

    debugPrint("Dio initialized");
  }

  @override
  Future<Response> getRequest({
    String baseUrl = EndPoints.baseUrl,
    required String path,
    Map<String, dynamic>? queryParams,
  }) async {
    client.options.baseUrl = baseUrl;
    final Response response =
        await client.get(path, queryParameters: queryParams);
    debugPrint(
        "GET Request to ${response.realUri} with status code ${response.statusCode}");
    return response;
  }

  @override
  Future<Response> postRequest({
    String baseUrl = EndPoints.baseUrl,
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool isFormData = false,
  }) async {
    client.options.baseUrl = baseUrl;
    if (!isFormData) {
      return await client.post(
        path,
        queryParameters: queryParams,
        data: body,
      );
    } else {
      final formData = _buildFormData(body);
      return await client.post(
        path,
        queryParameters: queryParams,
        data: formData,
      );
    }
  }

  FormData _buildFormData(Map<String, dynamic>? body) {
    final formData = FormData();
    body?.forEach((key, value) {
      if (value is String && value.endsWith('.jpg')) {
        formData.files.add(MapEntry(key, MultipartFile.fromFileSync(value)));
      } else {
        formData.fields.add(MapEntry(key, value?.toString() ?? ''));
      }
    });
    return formData;
  }

  @override
  Future<Response> putRequest({
    String baseUrl = EndPoints.baseUrl,
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool isFormData = false,
  }) async {
    final Response response = await client.put(
      path,
      queryParameters: queryParams,
      data: isFormData ? FormData.fromMap(body!) : body,
    );
    return jsonDecode(response.data.toString());
  }

  @override
  Future<Response> deleteRequest({
    String baseUrl = EndPoints.baseUrl,
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    final Response response = await client.delete(
      path,
      queryParameters: queryParams,
      data: body,
    );
    return jsonDecode(response.data.toString());
  }
}
