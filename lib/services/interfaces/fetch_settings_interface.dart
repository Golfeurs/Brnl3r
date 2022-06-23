// Interface
// Storage access for settings and url generation

abstract class FetchSettingsInterface {
  Future<String?> getData(String key);
  void setData(String key, String value);
  Future<String?> getQuestionDifficulty();
  Future<String?> getQuestionAmount();
}
