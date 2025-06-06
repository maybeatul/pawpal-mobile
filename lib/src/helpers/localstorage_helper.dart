import 'package:shared_preferences/shared_preferences.dart';

class  LocalstorageHelper {
  static SharedPreferences ? _preferences;

  // Call this once when your app starts (e.g., in main())
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Set a value
  static Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // static Future<void> setBool(String key, bool value) async {
  //   await _preferences?.setBool(key, value);
  // }

  // static Future<void> setInt(String key, int value) async {
  //   await _preferences?.setInt(key, value);
  // }
  // static Future<void> setDouble(String key, double value) async {
  //   await _preferences?.setDouble(key, value);
  // }

  // Get a value
  static String? getString(String key) {
    return _preferences?.getString(key);
  }
  // static bool? getBool(String key) {
  //   return _preferences?.getBool(key);
  // }
  // static int? getInt(String key) {
  //   return _preferences?.getInt(key);
  // }
  // static double? getDouble(String key) {
  //   return _preferences?.getDouble(key);
  // }
  // // Remove a value
  // static Future<void> remove(String key) async {
  //   await _preferences?.remove(key);
  // }
  // Clear all values 
  static Future<void> clear() async {
    await _preferences?.clear();
  }
  // Check if a key exists
  // static bool containsKey(String key) {
  //   return _preferences?.containsKey(key) ?? false;
  // }
  // // Get all keys
  // static Set<String> getKeys() {
  //   return _preferences?.getKeys() ?? {};
  // }
  // Get all values

  // static Map<String, dynamic> getAllValues() {
  //   final keys = _preferences?.getKeys() ?? {};
  //   final Map<String, dynamic> allValues = {};
  //   for (String key in keys) {
  //     allValues[key] = _preferences?.get(key);
  //   }
  //   return allValues;
  // }

  
}
