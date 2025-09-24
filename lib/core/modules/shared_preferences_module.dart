import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferencesModule {
  @preResolve
  @singleton
  Future<SharedPreferences> provideSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }
}

@singleton
class SharedPrefHelper {
  final SharedPreferences _sharedPreferences;

  SharedPrefHelper(this._sharedPreferences);

  ///Below method is to return the SharedPreference instance.
  SharedPreferences getPreferenceInstance() {
    return _sharedPreferences;
  }

  Future<void> setValue(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else {
      throw Exception("Invalid value type");
    }
  }

  dynamic getValue(String key) {
    return _sharedPreferences.get(key);
  }

  ///Below method is to remove the received preference.
  Future<void> removePreference({required String key}) async {
    await _sharedPreferences.remove(key);
  }
}
