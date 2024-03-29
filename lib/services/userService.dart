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

  static Future<void> addToBasket(String idArticle) async {
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
    final prefs = await SharedPreferences.getInstance();
    final prefsUserStored = prefs.getString("user");
    final user = jsonDecode(prefsUserStored!) as Map<String, dynamic>;
    final basket = user["basket"];
    final result = <ClothingModel>[];
    for (final idArticle in basket) {
      final doc = await FirebaseFirestore.instance
          .collection('clothings')
          .doc(idArticle)
          .get();
      if (doc.exists) {
        final article = doc.data()!;
        final data = ClothingModel(
            id: doc.id,
            brand: article["brand"],
            name: article["name"],
            photoUrl: article["photoUrl"],
            price: article["price"],
            size: article["size"]);
        result.add(data);
      }
    }
    return result;
  }

  static Future<void> removeFromBasket(String? idArticle) async {
    final prefs = await SharedPreferences.getInstance();
    final prefsUserStored = prefs.getString("user");
    final Map<String, dynamic> user = jsonDecode(prefsUserStored!);
    final List<dynamic> basket = List<dynamic>.from(user["basket"]);

    if (!basket.contains(idArticle)) {
      print("L'article avec l'ID $idArticle n'est pas présent dans le panier.");
      return;
    }

    basket.remove(idArticle);
    user["basket"] = basket;

    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(user["idUser"])
        .set(user)
        .then((_) {
      print('Panier mis à jour');
      final encodedUser = jsonEncode(user);
      prefs.setString('user', encodedUser);
    }).catchError((error) =>
            print('Erreur lors de la mise à jour du document: $error'));
  }

  static Future<UserModel> getProfile() async {
    var prefs = await SharedPreferences.getInstance();
    var prefsUserStored = prefs.getString("user");
    var user = jsonDecode(prefsUserStored!);
    var result;
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(user["idUser"])
        .get()
        .then((snapshot) {
      result = UserModel.fromJson(snapshot.data());
    }).catchError((error) =>
            print('Erreur lors de la mise à jour du document: $error'));
    return result;
  }

  static void changePassword(String newPassword) async {
    //Create an instance of the current user.
    final user = FirebaseAuth.instance.currentUser;
    try {
      await user?.updatePassword(newPassword);
      print("Mot de passe mis à jour avec succès !");
    } catch (e) {
      print(
          "Une erreur s'est produite lors de la mise à jour du mot de passe : $e");
    }
  }

  static Future<void> updateProfile(userProfile) async {
    var prefs = await SharedPreferences.getInstance();
    var prefsUserStored = prefs.getString("user");
    var user = jsonDecode(prefsUserStored!);
    var result;
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(user["idUser"])
        .set(userProfile)
        .then((snapshot) {
      print("Profile mis à jour");
    }).catchError((error) =>
            print('Erreur lors de la mise à jour du document: $error'));
    return result;
  }

  static Future<void> logOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("user", "");
  }
}
