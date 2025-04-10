class Pokemon {
  final int dexNumber;
  final String name;
  final String imageUrl;
  final List<String> types;
  final String description;
  final double height;
  final double weight;
  bool isFavorite;

  Pokemon({
    required this.dexNumber,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.description,
    required this.height,
    required this.weight,
    this.isFavorite = false,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      dexNumber: json['dexNumber'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      types: List<String>.from(json['types'] as List),
      description: json['description'] as String,
      height: json['height'] as double,
      weight: json['weight'] as double,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dexNumber': dexNumber,
      'name': name,
      'imageUrl': imageUrl,
      'types': types,
      'description': description,
      'height': height,
      'weight': weight,
      'isFavorite': isFavorite,
    };
  }

  Pokemon copyWith({
    int? dexNumber,
    String? name,
    String? imageUrl,
    List<String>? types,
    String? description,
    double? height,
    double? weight,
    bool? isFavorite,
  }) {
    return Pokemon(
      dexNumber: dexNumber ?? this.dexNumber,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      types: types ?? this.types,
      description: description ?? this.description,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}