import 'package:dio/dio.dart';

import '../../models/response_code.dart';
import '../../models/response_messages.dart';
import '../../utils/app_strings.dart';
import '../abstract/failure.dart';
import '../network_enums.dart';

//! Using Exceptions Rather than Return Errors Is Recommended approch from Clean Code Book ...

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
    final errorMap = {
      DioExceptionType.connectionTimeout:
          DataSource.CONNECT_TIMEOUT.getFailure(),
      DioExceptionType.sendTimeout: DataSource.SEND_TIMEOUT.getFailure(),
      DioExceptionType.receiveTimeout: DataSource.RECEIVE_TIMEOUT.getFailure(),
      DioExceptionType.badResponse: _handleBadResponse(error.response),
      DioExceptionType.cancel: DataSource.CANCEL.getFailure(),
      DioExceptionType.unknown: DataSource.DEFAULT.getFailure(),
      DioExceptionType.badCertificate: DataSource.DEFAULT.getFailure(),
      DioExceptionType.connectionError: DataSource.DEFAULT.getFailure(),
    };
    return errorMap[error.type] ?? DataSource.DEFAULT.getFailure();
  }

  Failure _handleBadResponse(Response? response) {
    if (response == null) {
      return DataSource.DEFAULT.getFailure();
    }
    final statusCodeMap = {
      ResponseCode.BAD_REQUEST: Failure(
          ResponseCode.BAD_REQUEST, _getUserFriendlyMessage("Bad Request")),
      ResponseCode.SERVER_ERROR: Failure(
          ResponseCode.SERVER_ERROR, _getUserFriendlyMessage("Server Error")),
      ResponseCode.NOT_FOUND:
          Failure(ResponseCode.NOT_FOUND, _getUserFriendlyMessage("Not Found")),
    };
    return statusCodeMap[response.statusCode] ??
        DataSource.DEFAULT.getFailure();
  }

  String _getUserFriendlyMessage(String key) {
    const messages = {
      "Bad Request": AppStrings.badRequest,
      "Server Error": AppStrings.serverErrorMessage,
      "Not Found": AppStrings.notFound,
    };
    return messages[key] ?? AppStrings.unexpectedError;
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    final failureMap = {
      DataSource.BAD_REQUEST:
          Failure(ResponseCode.BAD_REQUEST, ResponseMessage().BAD_REQUEST),
      DataSource.FORBIDDEN:
          Failure(ResponseCode.FORBIDDEN, ResponseMessage().FORBIDDEN),
      DataSource.UNAUTHORISED:
          Failure(ResponseCode.UNAUTHORISED, ResponseMessage().UNAUTHORISED),
      DataSource.NOT_FOUND:
          Failure(ResponseCode.NOT_FOUND, ResponseMessage().NOT_FOUND),
      DataSource.SERVER_ERROR:
          Failure(ResponseCode.SERVER_ERROR, ResponseMessage().SERVER_ERROR),
      DataSource.CONNECT_TIMEOUT: Failure(
          ResponseCode.CONNECT_TIMEOUT, ResponseMessage().CONNECT_TIMEOUT),
      DataSource.CANCEL: Failure(ResponseCode.CANCEL, ResponseMessage().CANCEL),
      DataSource.RECEIVE_TIMEOUT: Failure(
          ResponseCode.RECEIVE_TIMEOUT, ResponseMessage().RECEIVE_TIMEOUT),
      DataSource.SEND_TIMEOUT:
          Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage().SEND_TIMEOUT),
      DataSource.CACHE_WRITE_ERROR: Failure(
          ResponseCode.CACHE_READ_ERROR, ResponseMessage().CACHE_WRITE_ERROR),
      DataSource.CACHE_READ_ERROR: Failure(
          ResponseCode.CACHE_READ_ERROR, ResponseMessage().CACHE_READ_ERROR),
      DataSource.NO_INTERNET_CONNECTION: Failure(
          ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage().NO_INTERNET_CONNECTION),
      DataSource.BAD_CERTIFICATE_ERROR: Failure(
          ResponseCode.BAD_CERTIFICATION_ERROR,
          ResponseMessage().CERTIFICATION_ERROR),
      DataSource.CONNECTION_ERROR: Failure(
          ResponseCode.CONNECTION_ERROR, ResponseMessage().CONNECTION_ERROR),
      DataSource.DEFAULT:
          Failure(ResponseCode.DEFAULT, ResponseMessage().DEFAULT),
      DataSource.Unprocessable_Content: Failure(
          ResponseCode.Unprocessable_Content,
          ResponseMessage().Unprocessable_Content),
    };
    return failureMap[this] ??
        Failure(ResponseCode.DEFAULT, ResponseMessage().DEFAULT);
  }
}
