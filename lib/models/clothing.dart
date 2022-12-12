class ClothingModel {
  String? id;
  String? name;
  String? photoUrl;
  String? size;
  String? price;

  ClothingModel({
    this.id,
    this.name,
    this.photoUrl,
    this.size,
    this.price,
  });

  ClothingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photoUrl = json['photoUrl'];
    size = json['size'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photoUrl'] = photoUrl;
    data['size'] = size;
    data['price'] = price;
    return data;
  }
}
