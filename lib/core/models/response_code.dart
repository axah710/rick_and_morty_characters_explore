/// This abstracts class defines various HTTP status codes used for handling network responses.
/// By using this class, you can maintain consistency and avoid hardcoding status codes throughout your codebase.
library;
// ignore_for_file: constant_identifier_names

abstract class ResponseCode {
  //! Success code indicating a successful response with data.
  static const int SUCCESS = 200;
  static const int CACHE_WRITE_SUCCESS = 1;
  static const int CACHE_READ_SUCCESS = 2;
  static const int NOT_FOUND_IN_CACHE = 3;

  //! Success code indicating a successful response but without data.
  static const int NO_CONTENT = 201;

  //! Failure code indicating a bad request sent by the client.
  static const int BAD_REQUEST = 400;

  //! Failure code indicating the client is not authorized to access the resource.
  static const int FORBIDDEN = 403;

  //! Failure code indicating the client is not authenticated.
  static const int UNAUTHORISED = 401;

  //! Failure code indicating the requested resource could not be found.
  static const int NOT_FOUND = 404;

  //! Failure code indicating an internal server error occurred.
  static const int SERVER_ERROR = 500;

  //! Failure code indicating a conflict with the current state of the resource.
  static const int CONFLICT = 409;

  //! Local status codes

  //! Placeholder for a generic error or unspecified status code.
  static const int DEFAULT = -1;

  //! Indicates a connection timeout error.
  static const int CONNECT_TIMEOUT = -2;

  //! Indicates the request was canceled.
  static const int CANCEL = -3;

  //! Indicates a timeout while receiving data from the server.
  static const int RECEIVE_TIMEOUT = -4;

  //! Indicates a timeout while sending data to the server.
  static const int SEND_TIMEOUT = -5;

  //! Indicates an error with the server's SSL certificate.
  static const int BAD_CERTIFICATION_ERROR = -6;
  static const int CONNECTION_ERROR = -7;

  //! Indicates an error reading from the cache (if applicable).
  static const int CACHE_READ_ERROR = -8;

  //! Indicates an error writing to the cache (if applicable).
  static const int CACHE_WRITE_ERROR = -9;

  //! Indicates no internet connection is available.
  static const int NO_INTERNET_CONNECTION = -10;

  //! Indicates the request was unprocessable.
  static const int Unprocessable_Content = 422;
}
