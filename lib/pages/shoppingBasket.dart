import 'package:flutter/material.dart';
import 'package:miaged/services/userService.dart';

import '../services/clothingService.dart';
import '../widgets/carteArticle.dart';

class ShoppingBasketWidget extends StatefulWidget {
  const ShoppingBasketWidget({super.key});

  @override
  State<ShoppingBasketWidget> createState() => _ShoppingBasketWidgetState();
}

class _ShoppingBasketWidgetState extends State<ShoppingBasketWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.getBasket(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          for (var element in data) print(element);
          return ListView(children: [
            Text("teste"),
            for (var element in data)
              CarteArticle(
                id: element.id,
                name: element.name,
                price: element.price,
                size: element.size,
                photoUrl: element.photoUrl,
              ),
          ]);
        } else if (snapshot.hasError) {
          // Gestion des erreurs ici
          return Scaffold(
            appBar: AppBar(
              title: const Text('Erreur de connexion liste'),
            ),
            body: Center(
              child: Text('Erreur: ${snapshot.error}'),
            ),
          );
        } else {
          // Affichage d'un indicateur de chargement
          return Scaffold(
            appBar: AppBar(
              title: Text('Ma page'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
