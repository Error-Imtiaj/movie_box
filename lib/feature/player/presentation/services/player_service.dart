import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_box/core/router/routes.dart';
import 'package:movie_box/feature/player/presentation/services/player_url_builder.dart';
import 'package:movie_box/feature/player/presentation/services/watch_progress_service.dart';

class PlayerService {
  final WatchProgressService _watchProgress;
  static bool _isPlayerOpen = false;

  PlayerService(this._watchProgress);

  Future<void> openPlayer(
    BuildContext context, {
    required int tmdbId,
    required bool isTv,
    int season = 1,
    int episode = 1,
  }) async {
    if (_isPlayerOpen) return;
    _isPlayerOpen = true;

    try {
      final resumeTime = _watchProgress.getResumeTime(
        id: tmdbId,
        mediaType: isTv ? "tv" : "movie",
        season: isTv ? season : null,
        episode: isTv ? episode : null,
      );

      final url = isTv
          ? PlayerUrlBuilder.tv(
              tmdbId: tmdbId,
              season: season,
              episode: episode,
              progress: resumeTime,
            )
          : PlayerUrlBuilder.movie(
              tmdbId: tmdbId,
              progress: resumeTime,
            );

      await context.pushNamed(
        Routes.fullscreenPlayerScreen,
        extra: url,
      );
    } finally {
      _isPlayerOpen = false;
    }
  }
}
