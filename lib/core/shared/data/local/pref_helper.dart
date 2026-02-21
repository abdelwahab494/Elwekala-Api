import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _tokenKey = "auth_token";
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  static String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    _prefs.remove(_tokenKey);
  }
}
