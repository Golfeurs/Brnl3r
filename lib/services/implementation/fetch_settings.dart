// Interface
// Storage access for settings and url generation

import 'package:brnl3r/services/interfaces/fetch_settings_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchSettings implements FetchSettingsInterface {
  static const String difficultyKey = "difficulty";
  static const String amountQKey = "amoutQ";

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
  Future<String?> getQuestionDifficulty() async {
    final prefs = await SharedPreferences.getInstance();
    String? difficulty = prefs.getString(difficultyKey);

    return difficulty;
  }

  @override
  Future<String?> getQuestionAmount() async {
    final prefs = await SharedPreferences.getInstance();
    String? amount = prefs.getString(amountQKey);

    return amount;
  }
}
