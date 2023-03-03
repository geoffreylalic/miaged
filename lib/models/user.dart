class UserModel {
  String? username;
  String? email;
  String? photoUrl;
  String? token;
  String? address;
  String? zipCode;
  String? city;
  String? idUser;
  int? birthdate;

  UserModel({
    this.username,
    this.email,
    this.token,
    this.address,
    this.zipCode,
    this.city,
    this.idUser,
    this.birthdate,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    token = json['token'];
    address = json['address'];
    zipCode = json['zipCode'];
    city = json['city'];
    idUser = json['idUser'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['photoUrl'] = photoUrl;
    data['token'] = token;
    data['address'] = address;
    data['zipCode'] = zipCode;
    data['city'] = city;
    data['idUser'] = idUser;
    data['birthdate'] = birthdate;
    return data;
  }
}
