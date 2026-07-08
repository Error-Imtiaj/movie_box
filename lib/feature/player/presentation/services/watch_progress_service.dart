import 'package:movie_box/core/services/local_storage/services/local_storage_service.dart';

class WatchProgressService {
  final LocalStorageService _storage;

  WatchProgressService(this._storage);
  // SAVE WATCH PROGRESS
  Future<void> save({
    required int id,
    required String mediaType,
    required double currentTime,
    required double duration,
    required double progress,
    int? season,
    int? episode,
  }) {
    return _storage.saveWatchProgress(
      id: id,
      mediaType: mediaType,
      currentTime: currentTime,
      duration: duration,
      progress: progress,
      season: season,
      episode: episode,
    );
  }

  // GET WATCH PROGRESS
  Map<String, dynamic>? get({
    required int id,
    required String mediaType,
    int? season,
    int? episode,
  }) {
    return _storage.getWatchProgress(
      id: id,
      mediaType: mediaType,
      season: season,
      episode: episode,
    );
  }

  // GET RESUME TIME
  int getResumeTime({
    required int id,
    required String mediaType,
    int? season,
    int? episode,
  }) {
    return _storage.getResumeTime(
      id: id,
      mediaType: mediaType,
      season: season,
      episode: episode,
    );
  }

  // GET LAST WATCHED TV EPISODE
  Map<String, dynamic>? getLastWatchedEpisode({
    required int tvId,
  }) {
    return _storage.getLastWatchedEpisode(
      tvId: tvId,
    );
  }

  // CLEAR WATCH PROGRESS
  Future<void> clear({
    required int id,
    required String mediaType,
    int? season,
    int? episode,
  }) {
    return _storage.removeWatchProgress(
      id: id,
      mediaType: mediaType,
      season: season,
      episode: episode,
    );
  }
}
