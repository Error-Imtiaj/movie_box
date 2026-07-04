import 'dart:convert';

class CastModel {
  final int id;
  final String name;
  final String originalName;
  final String character;
  final String? profilePath;
  final String knownForDepartment;
  final double popularity;
  final int castOrder;

  const CastModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.character,
    required this.profilePath,
    required this.knownForDepartment,
    required this.popularity,
    required this.castOrder,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      character: json['character'] ?? '',
      profilePath: json['profile_path'],
      knownForDepartment: json['known_for_department'] ?? '',
      popularity: (json['popularity'] ?? 0).toDouble(),
      castOrder: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'original_name': originalName,
    'character': character,
    'profile_path': profilePath,
    'known_for_department': knownForDepartment,
    'popularity': popularity,
    'order': castOrder,
  };

  factory CastModel.fromRawJson(String source) =>
      CastModel.fromJson(json.decode(source));

  String toRawJson() => json.encode(toJson());

  CastModel copyWith({
    int? id,
    String? name,
    String? originalName,
    String? character,
    String? profilePath,
    String? knownForDepartment,
    double? popularity,
    int? castOrder,
  }) {
    return CastModel(
      id: id ?? this.id,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      character: character ?? this.character,
      profilePath: profilePath ?? this.profilePath,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      popularity: popularity ?? this.popularity,
      castOrder: castOrder ?? this.castOrder,
    );
  }

  @override
  String toString() {
    return 'CastModel(id: $id, name: $name, character: $character)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CastModel &&
            id == other.id &&
            name == other.name &&
            character == other.character &&
            profilePath == other.profilePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        character.hashCode ^
        profilePath.hashCode;
  }
}
