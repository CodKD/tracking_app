import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  factory SharedPrefHelper() {
    return preferences;
  }

  SharedPrefHelper._internal();

  static final SharedPrefHelper preferences =
      SharedPrefHelper._internal();

  static late SharedPreferences sharedPreferences;

  ///Below method is to initialize the SharedPreference instance.
  Future<dynamic> instantiatePreferences() async {
    sharedPreferences =
        await SharedPreferences.getInstance();
  }
  ///Below method is to set the string value in the SharedPreferences.
  Future<dynamic> setString({
    required String key,
    required String stringValue,
  }) async {
    await sharedPreferences.setString(key, stringValue);
  }

  ///Below method is to get the string value from the SharedPreferences.
  String? getString({required String key}) {
    return sharedPreferences.getString(key);
  }

  ///Below method is to set the boolean value in the SharedPreferences.
  Future<dynamic> setBoolean({
    required String key,
    required bool boolValue,
  }) async {
    await sharedPreferences.setBool(key, boolValue);
  }

  ///Below method is to get the boolean value from the SharedPreferences.
  bool? getBoolean({required String key}) {
    return sharedPreferences.getBool(key);
  }


  ///Below method is to return the SharedPreference instance.
  SharedPreferences getPreferenceInstance() {
    return sharedPreferences;
  }

  Future<void> setValue(String key, dynamic value) async {
    if (value is String) {
      await sharedPreferences.setString(key,  value);
    } else if (value is int) {
      await sharedPreferences.setInt(key,  value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key,  value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key,  value);
    } else {
      throw Exception("Invalid value type");
    }
  }


  dynamic getValue(String key) {
    return sharedPreferences.get(key);
  }

  ///Below method is to remove the received preference.
  Future<dynamic> removePreference({
    required String key,
  }) async {
    await sharedPreferences.remove(key);
  }

}
