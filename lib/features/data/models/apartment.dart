class Apartment {
  final int? id;
  final int? floor;
  final double? length;
  final double? width;
  final String? apartmentType;

  Apartment({
    this.id,
    this.floor,
    this.length,
    this.width,
    this.apartmentType,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      id: json['id'] != null ? json['id'] as int : null,
      floor: json['floor'] != null ? json['floor'] as int : null,
      length: json['length'] != null ? json['length'] as double : null,
      width: json['width'] != null ? json['width'] as double : null,
      apartmentType: json['apartment_type'] != null
          ? json['apartment_type'] as String
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'floor': floor,
      'length': length,
      'width': width,
      'apartment_type': apartmentType,
    };
  }
}
