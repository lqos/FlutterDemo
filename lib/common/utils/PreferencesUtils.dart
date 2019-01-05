import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtils {
  static putString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> getString(String key, String defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getString(key) ?? defaultValue);
  }

  static putInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  static Future<int> getInt(String key, String defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getInt(key) ?? defaultValue);
  }

  static putBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key, bool defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getBool(key) ?? defaultValue);
  }

  static putDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  static Future<double> getDouble(String key, double defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getDouble(key) ?? defaultValue);
  }

  static putStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  static Future<List<String>> getStringList(
      String key, List<String> defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(key) ?? defaultValue);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
