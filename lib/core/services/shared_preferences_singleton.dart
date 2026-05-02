import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _instance;

  static Future<void> init() async {
    
    _instance = await SharedPreferences.getInstance();
  }

  static dynamic setBool({required String key, required bool value}) {
    _instance.setBool(key, value);
  }

  static bool getBool(String key) {
    return _instance.getBool(key) ?? false;
  }

  static dynamic setString({required String key, required String value}) {
    _instance.setString(key, value);
  }

  static String? getString(String key) {
    return _instance.getString(key);
  }

  static dynamic setInt({required String key, required int value}) {
    _instance.setInt(key, value);
  }

  static int getInt(String key) {
    return _instance.getInt(key) ?? 0;
  }

  static dynamic setDouble({required String key, required double value}) {
    _instance.setDouble(key, value);
  }

  static double getDouble(String key) {
    return _instance.getDouble(key) ?? 0.0;
  }
}
