class ClothingModel {
  String? id;
  String? name;
  String? photoUrl;
  String? size;
  int? price;
  String? brand;
  String? category;

  ClothingModel({
    this.id,
    this.name,
    this.photoUrl,
    this.size,
    this.price,
    this.brand,
    this.category,
  });

  ClothingModel.fromJson(Map<String, dynamic> json) {
    name = json['id'];
    name = json['name'];
    photoUrl = json['photoUrl'];
    size = json['size'];
    price = json['price'];
    brand = json['brand'];
    category = json['category'];
  }

  Map<String, dynamic> toJson(List<ClothingModel> value) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photoUrl'] = photoUrl;
    data['size'] = size;
    data['price'] = price;
    data['brand'] = brand;
    data['category'] = category;
    return data;
  }

  @override
  String toString() {
    return 'ClothingModel {id $id ,name $name photoUrl $photoUrl size $size price $price brand $brand, category $category}';
  }
}
