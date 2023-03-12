
import 'package:flutter/material.dart';
import 'package:miaged/models/user.dart';
import 'package:miaged/pages/authentication/landingPage.dart';
import 'package:miaged/services/userService.dart';

import 'clothingList.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _birthdate = DateTime.now();
  late bool _passwordVisible;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    UserService.getProfile().then((value) {
      setState(() {
        print("heere init state");
        user = value;
        _birthdate =
            DateTime.fromMicrosecondsSinceEpoch((user.birthdate as int));
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    print("here ");
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _birthdate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != _birthdate) {
      setState(() {
        user.birthdate = ((picked.millisecondsSinceEpoch) * 1000);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                initialValue: user.username,
                decoration: const InputDecoration(labelText: 'pseudo'),
                enabled: false,
              ),
              TextFormField(
                initialValue: user.password,
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
                  user.password = value!;
                },
              ),
              ListTile(
                title: const Text('Date de naissance'),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
                subtitle: _birthdate == null
                    ? const Text('Aucune date sélectionnée')
                    : Text('Date sélectionnée : ${_birthdate.toString()}'),
              ),
              TextFormField(
                initialValue: user.address,
                decoration: const InputDecoration(labelText: 'Adresse'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer une adresse valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  user.address = value!;
                },
              ),
              TextFormField(
                initialValue: user.zipCode,
                decoration: const InputDecoration(labelText: 'Code postal'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer un code postal valide.';
                  }
                  return null;
                },
                onSaved: (value) {
                  user.zipCode = value!;
                },
              ),
              TextFormField(
                initialValue: user.city,
                decoration: const InputDecoration(labelText: 'Ville'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == "") {
                    return 'Veuillez entrer une ville valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  user.city = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      UserService.updateProfile(user.toJson());
                      UserService.changePassword(user.password as String);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ClothingListWidget(
                                  wantedNavigation: "buy")));
                    }
                  },
                  child: const Text("Confirmer"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    print("pressed se deconnecter");
                    UserService.logOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LandingPageWidget()));
                    });
                  },
                  child: const Text("Se déconnecter"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
