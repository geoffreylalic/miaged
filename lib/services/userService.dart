import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/models/clothing.dart';
import 'package:miaged/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserService {
  static Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = userCredential.user;
    return user;
  }

  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = userCredential.user;
    return user;
  }

  static void addToBasket(String idArticle) async {
    var prefs = await SharedPreferences.getInstance();
    var prefsUserStored = prefs.getString("user");
    var user = jsonDecode(prefsUserStored!);
    user["basket"].add(idArticle);
    FirebaseFirestore.instance
        .collection('profiles')
        .doc(user["idUser"])
        .set(user)
        .then((value) {
      print('Panier mis à jour');
      var encodedUser = jsonEncode(user);
      prefs.setString('user', encodedUser);
    }).catchError((error) =>
            print('Erreur lors de la mise à jour du document: $error'));
    // UserModel profile = UserModel.fromJson(profilePrefs);
    // profile.basket.push(idArticle);
  }

  static Future<List<ClothingModel>> getBasket() async {
    var prefs = await SharedPreferences.getInstance();
    var prefsUserStored = prefs.getString("user");
    var user = jsonDecode(prefsUserStored!);
    var basket = user["basket"];
    List<ClothingModel> result = [];
    for (var idArticle in basket) {
      var doc = await FirebaseFirestore.instance
          .collection('clothings')
          .doc(idArticle)
          .get();
      var article = doc.data();
      var data = ClothingModel(
          id: doc.id,
          brand: article!["brand"],
          name: article["name"],
          photoUrl: article["photoUrl"],
          price: article["price"],
          size: article["size"]);
      result.add(data);
    }
    return result;
  }

  static void removeFromBasket(String? idArticle) async {
    var prefs = await SharedPreferences.getInstance();
    var prefsUserStored = prefs.getString("user");
    var user = jsonDecode(prefsUserStored!);
    var basket = user["basket"];
    basket.remove(idArticle);
    // prefs.setString("user", jsonDecode(user));
    FirebaseFirestore.instance
        .collection('profiles')
        .doc(user["idUser"])
        .set(user)
        .then((value) {
      print('Panier mis à jour');
      var encodedUser = jsonEncode(user);
      prefs.setString('user', encodedUser);
    }).catchError((error) =>
            print('Erreur lors de la mise à jour du document: $error'));
  }

  static getProfile() async {
    var prefs = await SharedPreferences.getInstance();
    var prefsUserStored = prefs.getString("user");
    var user = jsonDecode(prefsUserStored!);
    var result;
    FirebaseFirestore.instance
        .collection('profiles')
        .doc(user["idUser"])
        .get()
        .then((snapshot) {
      result = UserModel.fromJson(snapshot.data());
    }).catchError((error) =>
            print('Erreur lors de la mise à jour du document: $error'));
    return result;
  }
}
