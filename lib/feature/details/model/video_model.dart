class VideoModel {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;
  final bool official;
  final String publishedAt;

  const VideoModel({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
    required this.official,
    required this.publishedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      site: json['site'] ?? '',
      type: json['type'] ?? '',
      official: json['official'] ?? false,
      publishedAt: json['published_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'site': site,
      'type': type,
      'official': official,
      'published_at': publishedAt,
    };
  }

  VideoModel copyWith({
    String? id,
    String? key,
    String? name,
    String? site,
    String? type,
    bool? official,
    String? publishedAt,
  }) {
    return VideoModel(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      site: site ?? this.site,
      type: type ?? this.type,
      official: official ?? this.official,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  /// Convenience getter for YouTube thumbnail
  String get thumbnailUrl =>
      "https://img.youtube.com/vi/$key/maxresdefault.jpg";

  /// Convenience getter for YouTube watch URL
  String get youtubeUrl => "https://www.youtube.com/watch?v=$key";

  /// Whether the video is hosted on YouTube
  bool get isYoutube => site.toLowerCase() == "youtube";
}