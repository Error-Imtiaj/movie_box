import 'dart:convert';

class GenreModel {
  final int id;
  final String name;

  const GenreModel({required this.id, required this.name});

  GenreModel copyWith({int? id, String? name}) {
    return GenreModel(id: id ?? this.id, name: name ?? this.name);
  }

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory GenreModel.fromRawJson(String source) =>
      GenreModel.fromJson(json.decode(source));

  String toRawJson() => json.encode(toJson());

  @override
  String toString() {
    return 'GenreModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GenreModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
