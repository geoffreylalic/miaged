import 'dart:ffi';

class ClothingModel {
  String? id;
  String? name;
  String? photoUrl;
  String? size;
  int? price;
  String? description;
  String? brand;

  ClothingModel({
    this.id,
    this.name,
    this.photoUrl,
    this.size,
    this.price = 1,
    this.description,
    this.brand
  });

  ClothingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photoUrl = json['photoUrl'];
    size = json['size'];
    price = json['price'];
    description = json['description'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photoUrl'] = photoUrl;
    data['size'] = size;
    data['price'] = price;
    data['description'] = description;
    data['brand'] = brand;
    return data;
  }
}
