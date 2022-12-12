class UserModel {
  String? username;
  String? email;
  String? photoUrl;
  String? password;
  String? address;
  String? zipCode;
  String? city;
  String? id;
  bool? isOnline;

  UserModel({
    this.username,
    this.email,
    this.password,
    this.address,
    this.zipCode,
    this.city,
    this.id,
    this.isOnline,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    password = json['password'];
    address = json['address'];
    zipCode = json['zipCode'];
    city = json['city'];
    id = json['id'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['password'] = password;
    data['address'] = address;
    data['zipCode'] = zipCode;
    data['city'] = city;
    data['id'] = id;
    data['isOnline'] = isOnline;
    return data;
  }
}
