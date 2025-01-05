import '../../main.dart';

class SharedPrefUtil {
  static Future<void> storeIsRemember(bool value) async {
    await preferences?.setBool("IsRemember", value);
  }

  static bool getIsRemember() {
    return preferences?.getBool("IsRemember") ?? false;
  }

  static Future<void> storeBearerToken(String value) async {
    print("TOKEN ${preferences?.setString("BearerToken", value)}");
    await preferences?.setString("BearerToken", value);
  }

  static String getBearerToken() {
    return preferences?.getString("BearerToken") ?? "";
  }

  static Future<void> clear() async {
    await preferences?.clear();
  }
}
