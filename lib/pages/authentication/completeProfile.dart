import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({super.key});

  @override
  State<CompleteProfileWidget> createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _birthdate;
  late String _address;
  late String _zipCode;
  late String _city;

  @override
  Widget build(BuildContext context) {
    void completeProfile() async {
      final snapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .where('idUser', isEqualTo: 'oui')
          .limit(1)
          .get();
      if (snapshot.size > 0) {
        final user = snapshot.docs.first.data();
        print(user);
      } else {
        print('Aucun utilisateur trouvé.');
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
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Date de naissance'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == '') {
                    return 'Veuillez entrer une date de naissance';
                  }
                  return null;
                },
                onSaved: (value) {
                  _birthdate = value! as DateTime;
                },
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
                    completeProfile();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
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
