class AppPrefs {
  static final AppPrefs _instance = AppPrefs._internal();
  factory AppPrefs() => _instance;
  AppPrefs._internal();
  static String language = 'en';
  static const String prefsNewInstallKey = 'NEW_INSTALLATION';
}
