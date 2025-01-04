import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  static final SharedPrefUtil _instance = SharedPrefUtil._internal();
  SharedPreferences? _preferences;

  SharedPrefUtil._internal();

  static SharedPrefUtil get instance => _instance;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> storeIsRemember(bool value) async {
    await _preferences?.setBool("IsRemember", value);
  }

  bool getIsRemember() {
    return _preferences?.getBool("IsRemember") ?? false;
  }

  Future<void> storeBearerToken(String value) async {
    await _preferences?.setString("BearerToken", value);
  }

  String getBearerToken() {
    return _preferences?.getString("BearerToken") ?? "";
  }

  Future<void> clear() async {
    await _preferences?.clear();
  }
}
