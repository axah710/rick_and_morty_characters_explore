/// A utility class that holds all application string constants.
/// This class prevents instantiation and is used for managing string literals.
class AppStrings {
  AppStrings._(); //! Private constructor to prevent instantiation

  //! Messages
  static const String unprocessableContent = 'Had Semantic Errors';
  static const String certificationError = "certification_error";
  static const String connectionError = "connection_error";
  static const String badRequestError = "bad_request_error";
  static const String forbiddenError = "forbidden_error";
  static const String unauthorizedError = "unauthorized_error";
  static const String notFoundError = "not_found_error";
  static const String connectTimeOutError = "timeout_error";
  static const String defaultError = "An error occurred. Please try again.";
  static const String noInternetError = "No internet connection.";
  static const String cacheReadError = "cache_read_error";
  static const String cacheWriteError = "cache_write_error";
  static const String cacheWriteSuccess = "cache_write_success";
  static const String notFoundInCache = "not_found_in_cache";
  static const String cacheReadSuccess = "cache_read_success";
  static const String serverError = 'SERVER_ERROR';
  static const String noContent = "no_content";
  static const String success = "success";
  static const String errorOccurred = 'An error occurred. Please try again.';
  static const String badRequest = 'Something went wrong. Please try again.';
  static const String serverErrorMessage =
      'Our servers are currently down. Please try later.';
  static const String notFound = 'The requested resource could not be found.';
  static const String unexpectedError = 'An unexpected error occurred.';
  static const String favoritesFailureMessage =
      "Failed to load favorites";

  //! Main Strings
  static const String deny = 'Deny';
  static const String allow = 'Allow';
  static const String appTitle = 'Rick And Morty App';

  //! UI Labels
  static const String findYourCharacter = 'Find your character';
  static const String searchCharacter = 'Search Character';
  static const String favoriteCharacters = 'Favorite Characters';
  static const String noCharactersFound = 'No characters found.';

  //! Alert Messages
  static const String whoops = 'Whoops !!';
  static const String connectionErrorAlert =
      'There is a connection error. please check your internet and try again...';

  //! Dropdown Hints
  static const String selectStatus = 'Select Status';
  static const String selectSpecies = 'Select Species';

  //! Dropdown Items
  static const List<String> statusItems = ['Alive', 'Dead', 'unknown'];
  static const List<String> speciesItems = ['Human', 'Alien', 'Robot'];
}
