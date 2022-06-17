// Interface
// Storage access for settings and url generation

import 'package:brnl3r/services/interfaces/fetch_settings_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchSettings implements FetchSettingsInterface {
  @override
  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    return data;
  }

  @override
  void setData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getQuestionUrl() async {
    final prefs = await SharedPreferences.getInstance();
    String? amount = prefs.getString("amoutQ");
    String? difficulty = prefs.getString("difficulty");

    return "https://opentdb.com/api.php?amount=$amount&difficulty=$difficulty&type=multiple";
  }
}
