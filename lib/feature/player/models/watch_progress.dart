class WatchProgress {
  final int id;
  final String mediaType;
  final double progress;
  final double currentTime;
  final double duration;
  final int? season;
  final int? episode;

  WatchProgress({
    required this.id,
    required this.mediaType,
    required this.progress,
    required this.currentTime,
    required this.duration,
    this.season,
    this.episode,
  });

  factory WatchProgress.fromJson(Map<String, dynamic> json) {
    return WatchProgress(
      id: int.parse(json["id"].toString()),
      mediaType: json["mediaType"],
      progress: (json["progress"] as num).toDouble(),
      currentTime: (json["currentTime"] as num).toDouble(),
      duration: (json["duration"] as num).toDouble(),
      season: json["season"],
      episode: json["episode"],
    );
  }
}