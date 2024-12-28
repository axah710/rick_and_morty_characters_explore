import 'dart:convert';
import 'package:dio/dio.dart';
import '../../models/response_code.dart';
import '../../models/response_messages.dart';
import '../abstract/failure.dart';
import '../network_enums.dart';

//! Use Exceptions Rather than Return Errors Is Reccommended approch from Clean Code Book ...

class ErrorHandler implements Exception {
  ErrorHandler._internal();
  factory ErrorHandler() => ErrorHandler._internal();

  Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else {
      return DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        return DataSource.DEFAULT.getFailure();
    }
  }

  Failure _handleBadResponse(Response? response) {
    if (response == null) {
      return DataSource.DEFAULT.getFailure();
    }

    switch (response.statusCode) {
      case ResponseCode.BAD_REQUEST:
        return _extractErrorMessage(response, DataSource.BAD_REQUEST);
      case ResponseCode.SERVER_ERROR:
        return DataSource.SERVER_ERROR.getFailure();
      case ResponseCode.Unprocessable_Content:
        return DataSource.Unprocessable_Content.getFailure();
      case ResponseCode.FORBIDDEN:
        return DataSource.FORBIDDEN.getFailure();
      case ResponseCode.UNAUTHORISED:
        return DataSource.UNAUTHORISED.getFailure();
      case ResponseCode.NOT_FOUND:
        return DataSource.NOT_FOUND.getFailure();
      default:
        return DataSource.DEFAULT.getFailure();
    }
  }

  Failure _extractErrorMessage(Response response, DataSource dataSource) {
    final messageData = jsonDecode(response.data);
    final message = messageData["message"] ?? '';
    return Failure(ResponseCode.BAD_REQUEST, message);
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage().BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage().FORBIDDEN);
      case DataSource.UNAUTHORISED:
        return Failure(
            ResponseCode.UNAUTHORISED, ResponseMessage().UNAUTHORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage().NOT_FOUND);
      case DataSource.SERVER_ERROR:
        return Failure(
            ResponseCode.SERVER_ERROR, ResponseMessage().SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage().CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage().CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage().RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(
            ResponseCode.SEND_TIMEOUT, ResponseMessage().SEND_TIMEOUT);
      case DataSource.CACHE_WRITE_ERROR:
        return Failure(
            ResponseCode.CACHE_READ_ERROR, ResponseMessage().CACHE_WRITE_ERROR);
      case DataSource.CACHE_READ_ERROR:
        return Failure(
            ResponseCode.CACHE_READ_ERROR, ResponseMessage().CACHE_READ_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage().NO_INTERNET_CONNECTION);
      case DataSource.BAD_CERTIFICATE_ERROR:
        return Failure(ResponseCode.BAD_CERTIFICATION_ERROR,
            ResponseMessage().CERTIFICATION_ERROR);
      case DataSource.CONNECTION_ERROR:
        return Failure(
            ResponseCode.CONNECTION_ERROR, ResponseMessage().CONNECTION_ERROR);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage().DEFAULT);
      case DataSource.Unprocessable_Content:
        return Failure(ResponseCode.Unprocessable_Content,
            ResponseMessage().Unprocessable_Content);
      default:
        return Failure(ResponseCode.DEFAULT, ResponseMessage().DEFAULT);
    }
  }
}
