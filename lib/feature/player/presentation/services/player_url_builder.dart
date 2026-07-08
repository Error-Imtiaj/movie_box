import 'package:movie_box/core/const/app_strings.dart';

class PlayerUrlBuilder {
  static String movie({
    required int tmdbId,
    String color = "0dcaf0",
    bool autoPlay = true,
    int? progress,
  }) {
    var url =
        "${AppStrings.playerMovieUrl}/$tmdbId"
        "?color=$color"
        "&autoPlay=$autoPlay";

    if (progress != null && progress > 0) {
      url += "&progress=$progress";
    }

    return url;
  }

  static String tv({
    required int tmdbId,
    required int season,
    required int episode,
    String color = "0dcaf0",
    bool autoPlay = true,
    bool nextEpisode = true,
    bool episodeSelector = true,
    int? progress,
  }) {
    var url =
        "${AppStrings.playerTvUrl}/$tmdbId/$season/$episode"
        "?color=$color"
        "&autoPlay=$autoPlay"
        "&nextEpisode=$nextEpisode"
        "&episodeSelector=$episodeSelector";

    if (progress != null && progress > 0) {
      url += "&progress=$progress";
    }

    return url;
  }
}
