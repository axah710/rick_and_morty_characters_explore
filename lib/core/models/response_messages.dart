// ignore_for_file: non_constant_identifier_names

import '../utils/app_strings.dart';

class ResponseMessage {
  ResponseMessage._internal();

  static final ResponseMessage _instance = ResponseMessage._internal();
  factory ResponseMessage() => _instance;
  //! API status codes
  //! API response codes
  final String Unprocessable_Content = AppStrings.unprocessableContent;
  final String SUCCESS = AppStrings.success; //! success with data
  final String NO_CONTENT = AppStrings.noContent; //! success with no content
  final String BAD_REQUEST =
      AppStrings.badRequestError; //! failure, network rejected our request
  final String FORBIDDEN =
      AppStrings.forbiddenError; //! failure,  network rejected our request
  final String UNAUTHORISED =
      AppStrings.unauthorizedError; //! failure, user is not authorised
  final String SERVER_ERROR = AppStrings
      .serverError; //! failure, API url is not correct and not found in network side.
  final String NOT_FOUND = AppStrings
      .notFoundError; //! failure, API url is not correct and not found in network side.

  //! local responses codes
  final String DEFAULT = AppStrings.defaultError; //! unknown error happened
  final String CONNECT_TIMEOUT =
      AppStrings.connectTimeOutError; //! issue in connectivity
  final String CANCEL = AppStrings.defaultError; //! API request was cancelled
  final String RECEIVE_TIMEOUT =
      AppStrings.connectTimeOutError; //!  issue in connectivity
  final String SEND_TIMEOUT =
      AppStrings.connectTimeOutError; //!  issue in connectivity
  final String CERTIFICATION_ERROR =
      AppStrings.certificationError; //!  issue in connectivity
  final String CACHE_WRITE_ERROR = AppStrings
      .cacheWriteError; //!  issue in getting data from local data source (cache)
  final String CACHE_WRITE_SUCCESS = AppStrings
      .cacheWriteSuccess; //!  issue in getting data from local data source (cache)
  final String CACHE_READ_ERROR = AppStrings
      .cacheReadError; //!  issue in getting data from local data source (cache)
  final String NO_INTERNET_CONNECTION = AppStrings.noInternetError;

  final String CONNECTION_ERROR = AppStrings.connectionError;

  final String NOT_FOUND_IN_CACHE = AppStrings.notFoundInCache;

  final String CACHE_READ_SUCCESS =
      AppStrings.cacheReadSuccess; //! issue in connectivity
}
