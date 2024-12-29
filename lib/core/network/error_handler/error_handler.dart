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
        return Failure(
            ResponseCode.BAD_REQUEST, _getUserFriendlyMessage("Bad Request"));
      case ResponseCode.SERVER_ERROR:
        return Failure(
            ResponseCode.SERVER_ERROR, _getUserFriendlyMessage("Server Error"));
      case ResponseCode.UNAUTHORISED:
        return Failure(
            ResponseCode.UNAUTHORISED, _getUserFriendlyMessage("Unauthorized"));
      case ResponseCode.NOT_FOUND:
        return Failure(
            ResponseCode.NOT_FOUND, _getUserFriendlyMessage("Not Found"));
      default:
        return DataSource.DEFAULT.getFailure();
    }
  }

  String _getUserFriendlyMessage(String key) {
    //! Maped error keys to user-friendly messages
    const messages = {
      "Bad Request": "Something went wrong. Please try again.",
      "Server Error": "Our servers are currently down. Please try later.",
      "Unauthorized": "You are not authorized to perform this action.",
      "Not Found": "The requested resource could not be found.",
    };

    return messages[key] ?? "An unexpected error occurred.";
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
