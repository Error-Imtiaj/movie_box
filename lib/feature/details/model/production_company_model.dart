class ProductionCompanyModel {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  const ProductionCompanyModel({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanyModel.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyModel(
      id: json['id'] ?? 0,
      logoPath: json['logo_path'],
      name: json['name'] ?? '',
      originCountry: json['origin_country'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo_path': logoPath,
      'name': name,
      'origin_country': originCountry,
    };
  }

  ProductionCompanyModel copyWith({
    int? id,
    String? logoPath,
    String? name,
    String? originCountry,
  }) {
    return ProductionCompanyModel(
      id: id ?? this.id,
      logoPath: logoPath ?? this.logoPath,
      name: name ?? this.name,
      originCountry: originCountry ?? this.originCountry,
    );
  }
}