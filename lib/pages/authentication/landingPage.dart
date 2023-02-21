import 'dart:html';

import 'package:flutter/material.dart';
import 'package:miaged/pages/authentication/login.dart';
import 'package:miaged/pages/authentication/register.dart';

class LandingPageWidget extends StatelessWidget {
  const LandingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text(
              "Vends sans frais ce que tu ne portes plus. Rejoins-nous!",
              style: TextStyle()),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterWidget()),
                  );
                },
                child: const Text(
                  "S'inscrire sur Miaged",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                )),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                print("clicked");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginWidget()),
                );
              },
              child: const Text(
                "J'ai déjà un compte",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
