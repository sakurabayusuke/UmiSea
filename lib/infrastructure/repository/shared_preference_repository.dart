import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  static late final SharedPreferences _prefs;

  factory SharedPreferenceRepository() =>
      SharedPreferenceRepository._internal();

  SharedPreferenceRepository._internal();

  // アプリ起動時に必ず呼び出すこと。
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int? getInt(String param) => _prefs.getInt(param);
  bool? getBool(String param) => _prefs.getBool(param);
  double? getDouble(String param) => _prefs.getDouble(param);
  String? getString(String param) => _prefs.getString(param);
  List<String>? getStringList(String param) => _prefs.getStringList(param);

  setInt(String param, int value) => _prefs.setInt(param, value);
  setBool(String param, bool value) => _prefs.setBool(param, value);
  setDouble(String param, double value) => _prefs.setDouble(param, value);
  setString(String param, String value) => _prefs.setString(param, value);
  setStringList(String param, List<String> value) =>
      _prefs.setStringList(param, value);
}
