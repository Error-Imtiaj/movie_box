import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageService(this.prefs);

  // Keys
  static const String _firstTimeKey = 'first_time';
  static const String _apiKey = 'api_key';
  // Watch Progress
  static const String _watchProgressPrefix = 'watch_progress_';

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

  // Save Watch Progress
  Future<void> saveWatchProgress({
    required int id,
    required String mediaType,
    required double currentTime,
    required double duration,
    required double progress,
    int? season,
    int? episode,
  }) async {
    final key = _watchProgressKey(
      id: id,
      mediaType: mediaType,
      season: season,
      episode: episode,
    );

    await prefs.setString(
      key,
      jsonEncode({
        "id": id,
        "mediaType": mediaType,
        "currentTime": currentTime,
        "duration": duration,
        "progress": progress,
        "season": season,
        "episode": episode,
        "updatedAt": DateTime.now().millisecondsSinceEpoch,
      }),
    );
  }
  // GET WATCH PROGRESS

  Map<String, dynamic>? getWatchProgress({
    required int id,
    required String mediaType,
    int? season,
    int? episode,
  }) {
    final key = _watchProgressKey(
      id: id,
      mediaType: mediaType,
      season: season,
      episode: episode,
    );

    final json = prefs.getString(key);
    if (json == null) return null;
    return jsonDecode(json);
  }
  // GET RESUME TIME

  int getResumeTime({
    required int id,
    required String mediaType,
    int? season,
    int? episode,
  }) {
    final data = getWatchProgress(
      id: id,
      mediaType: mediaType,
      season: season,
      episode: episode,
    );

    if (data == null) return 0;

    return ((data["currentTime"] ?? 0) as num).toInt();
  }

  // GET LAST WATCHED TV EPISODE
  Map<String, dynamic>? getLastWatchedEpisode({
    required int tvId,
  }) {
    Map<String, dynamic>? latest;

    for (final key in prefs.getKeys()) {
      final prefix = "${_watchProgressPrefix}${tvId}_";

      if (!key.startsWith(prefix)) continue;

      final value = prefs.getString(key);
      if (value == null) continue;

      final data = jsonDecode(value) as Map<String, dynamic>;

      if (latest == null ||
          (data['updatedAt'] ?? 0) > (latest['updatedAt'] ?? 0)) {
        latest = data;
      }
    }

    return latest;
  }
  // REMOVE WATCH PROGRESS

  Future<void> removeWatchProgress({
    required int id,
    required String mediaType,
    int? season,
    int? episode,
  }) async {
    await prefs.remove(
      _watchProgressKey(
        id: id,
        mediaType: mediaType,
        season: season,
        episode: episode,
      ),
    );
  }
  // BUILD WATCH PROGRESS KEY

  String _watchProgressKey({
    required int id,
    required String mediaType,
    int? season,
    int? episode,
  }) {
    if (mediaType == "tv") {
      return "${_watchProgressPrefix}${id}_${season ?? 1}_${episode ?? 1}";
    }

    return "${_watchProgressPrefix}$id";
  }
}
