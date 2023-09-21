import 'package:finding_apartments_yangon/features/data/models/apartment.dart';
import 'package:finding_apartments_yangon/features/data/models/picture.dart';

class Post {
  int? id;
  String? contract;
  String? description;
  double? price;
  int? tenants;
  String? state;
  String? township;
  String? additional;
  Apartment? apartment;
  List<Picture>? pictures;

  Post({
    this.id,
    this.contract,
    this.description,
    this.price,
    this.tenants,
    this.state,
    this.township,
    this.additional,
    this.apartment,
    this.pictures,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<Picture> picturesList = (json['pictures'] as List? ?? [])
        .map((pic) => Picture.fromJson(pic))
        .toList();

    Map<String, dynamic> apartmentMap =
        json['apartment'] as Map<String, dynamic>;
    Apartment? apartment =
        apartmentMap != null ? Apartment.fromJson(apartmentMap) : null;

    return Post(
      id: json['id'] as int?,
      contract: json['contract'] as String?,
      description: json['description'] as String?,
      price: json['price'] as double?,
      tenants: json['tenants'] as int?,
      state: json['state'] as String?,
      township: json['township'] as String?,
      additional: json['additional'] as String?,
      apartment: apartment,
      pictures: picturesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contract': contract,
      'description': description,
      'price': price,
      'tenants': tenants,
      'state': state,
      'township': township,
      'additional': additional,
      'apartment': apartment != null ? apartment!.toJson() : null,
      'pictures': pictures,
    };
  }
}
