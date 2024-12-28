import 'package:shared_preferences/shared_preferences.dart';

import '../utils/debug_prints.dart';

class SharedPreferencesHelper {
  // Private constructor
  SharedPreferencesHelper._privateConstructor();

  // Static instance of the class
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._privateConstructor();

  // Factory constructor to return the static instance
  factory SharedPreferencesHelper() {
    return _instance;
  }

  // SharedPreferences instance
  static SharedPreferences? _sharedPreferences;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Check if SharedPreferences is initialized
  Future<void> _checkInitialization() async {
    if (_sharedPreferences == null) {
      await init();
    }
  }

  //! SharedPreferences Methods
  Future<void> removeData(String key) async {
    await _checkInitialization();
    Logger.printDone('SharedPrefHelper: data with key: $key has been removed');
    await _sharedPreferences!.remove(key);
  }

  Future<void> clearAllData() async {
    await _checkInitialization();
    Logger.printDone('SharedPrefHelper: all data has been cleared');
    await _sharedPreferences!.clear();
  }

  Future<void> setData(String key, dynamic value) async {
    await _checkInitialization();
    Logger.printDone(
        "SharedPrefHelper: setData with key: $key and value: $value");
    if (value is String) {
      await _sharedPreferences!.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences!.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences!.setDouble(key, value);
    }
  }

  Future<bool> getBool(String key) async {
    await _checkInitialization();
    Logger.printInfo('SharedPrefHelper: getBool with key: $key');
    return _sharedPreferences!.getBool(key) ?? false;
  }

  Future<double> getDouble(String key) async {
    await _checkInitialization();
    Logger.printInfo('SharedPrefHelper: getDouble with key: $key');
    return _sharedPreferences!.getDouble(key) ?? 0.0;
  }

  Future<int> getInt(String key) async {
    await _checkInitialization();
    Logger.printInfo('SharedPrefHelper: getInt with key: $key');
    return _sharedPreferences!.getInt(key) ?? 0;
  }

  Future<String> getString(String key) async {
    await _checkInitialization();
    Logger.printInfo('SharedPrefHelper: getString with key: $key');
    return _sharedPreferences!.getString(key) ?? '';
  }
}
