import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/pages/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({super.key});

  @override
  State<CompleteProfileWidget> createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _birthdate = DateTime.now();
  late String _address;
  late String _zipCode;
  late String _city;

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      if (picked != null && picked != _birthdate) {
        setState(() {
          _birthdate = picked;
        });
      }
    }

    void completeProfile() async {
      var prefs = await SharedPreferences.getInstance();
      var prefsUserStored = prefs.getString("user");
      var user = jsonDecode(prefsUserStored!);
      final snapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .where('idUser', isEqualTo: user["idUser"])
          .limit(1)
          .get();
      if (snapshot.size > 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginWidget()));
      } else {
        print('Aucun utilisateur trouvé.');
        user["birthdate"] = _birthdate;
        user["address"] = _address;
        user["zipCode"] = _zipCode;
        user["city"] = _city;
        final docRef = FirebaseFirestore.instance
            .collection('profiles')
            .doc(user["idUser"]);
        docRef.set(user).then((value) => print("Profile créé")).catchError(
            (error) => print("Erreur lors de la création du profile: $error"));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeWidget()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // TextFormField(
              //   decoration:
              //       const InputDecoration(labelText: 'Date de naissance'),
              //   keyboardType: TextInputType.datetime,
              //   validator: (value) {
              //     if (value == '') {
              //       return 'Veuillez entrer une date de naissance';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     _birthdate = value! as DateTime;
              //   },
              // ),
              ListTile(
                title: const Text('Date de naissance'),
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
                subtitle: _birthdate == null
                    ? const Text('Aucune date sélectionnée')
                    : Text('Date sélectionnée : ${_birthdate.toString()}'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Adresse'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer une adresse valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Code postal'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer un code postal valide.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _zipCode = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ville'),
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer une ville valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _city = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      completeProfile();
                      // Enregistrer les données de l'utilisateur
                    }
                  },
                  child: const Text("Confirmer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
