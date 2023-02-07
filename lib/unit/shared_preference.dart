import 'package:shared_preferences/shared_preferences.dart';

class ShareData {
  SharedPreferences? prefs;

  Future<void> setInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setStringShareData(String key, String value) {
    prefs?.setString(key, value);
  }

  String getStringShareData(String key) {
    return prefs?.getString(key) ?? '';
  }
}
