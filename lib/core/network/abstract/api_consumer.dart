import '../constants/endpoinst.dart';

/// An abstract class that defines methods for making API requests.
abstract class ApiConsumer {
  /// Sends a GET request to the specified [path] with optional [queryParams].
  ///
  /// [baseUrl] defaults to [EndPoints.baseUrl].
  Future getRequest({
    String baseUrl = EndPoints.baseUrl,
    required String path,
    Map<String, dynamic>? queryParams,
  });

  /// Sends a POST request to the specified [path] with an optional [body] and [queryParams].
  ///
  /// [baseUrl] defaults to [EndPoints.baseUrl].
  Future postRequest({
    String baseUrl = EndPoints.baseUrl,
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  });

  /// Sends a PUT request to the specified [path] with an optional [body] and [queryParams].
  ///
  /// [baseUrl] defaults to [EndPoints.baseUrl].
  Future putRequest({
    String baseUrl = EndPoints.baseUrl,
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  });

  /// Sends a DELETE request to the specified [path] with an optional [body] and [queryParams].
  ///
  /// [baseUrl] defaults to [EndPoints.baseUrl].
  Future deleteRequest({
    String baseUrl = EndPoints.baseUrl,
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  });
}
