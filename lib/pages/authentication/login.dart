import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/pages/clothingList.dart';
import 'package:miaged/pages/home.dart';
import 'package:miaged/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' show JSON;

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _password;
  late bool _passwordVisible;
  late final double _height = MediaQuery.of(context).size.height;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Se connecter'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: _height * 0.2),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer un email';
                  }
                  if (!value!.contains('@')) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )),
                obscureText: !_passwordVisible,
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer un mot de passe';
                  }
                  if (value!.length < 6) {
                    return 'Le mot de passe doit contenir au moins 6 caractères';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final prefs = await SharedPreferences.getInstance();
                      // Enregistrer les données de l'utilisateur
                      UserService.signInWithEmailAndPassword(_email, _password)
                          .then((value) async {
                        var user = UserModel(
                            idUser: value!.uid, token: value.refreshToken);
                        final snapshot = await FirebaseFirestore.instance
                            .collection('profiles')
                            .doc(user.idUser)
                            .get();
                        var profile = snapshot.data();
                        var birthdate = profile!["birthdate"];
                        // todo to retrieve exact date
                        // DateTime.fromMillisecondsSinceEpoch(
                        //     profile!["birthdate"].seconds * 1000);
                        user.birthdate = birthdate;
                        user.photoUrl = profile!["photoUrl"];
                        user.username = profile["username"];
                        user.email = profile["email"];
                        user.city = profile["city"];
                        user.address = profile["address"];
                        user.zipCode = profile["zipCode"];
                        user.basket = profile["basket"];
                        await prefs.setString(
                            'user', jsonEncode(user.toJson()));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ClothingListWidget(
                                    wantedNavigation: "buy")));
                      }).onError((error, stackTrace) {
                        print("error login $error");
                      });
                    }
                  },
                  child: const Text("Se connecter"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
