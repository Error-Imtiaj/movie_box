import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageService(this.prefs);

  // Keys
  static const String _firstTimeKey = 'first_time';
  static const String _apiKey = 'api_key';

  // First Time
  bool get isFirstTime => prefs.getBool(_firstTimeKey) ?? true;

  Future<void> setFirstTime(bool value) async {
    await prefs.setBool(_firstTimeKey, value);
  }

  // API Key
  String get getApiKey => prefs.getString(_apiKey) ?? '';

  Future<void> setApiKey(String value) async {
    await prefs.setString(_apiKey, value);
  }

  Future<void> removeApiKey() async {
    await prefs.remove(_apiKey);
  }

  // Returns true only if the API key exists and is not empty
  bool get hasApiKey {
    final apiKey = prefs.getString(_apiKey);
    return apiKey != null && apiKey.trim().isNotEmpty;
  }
}
