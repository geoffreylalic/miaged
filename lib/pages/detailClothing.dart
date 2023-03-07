import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged/pages/clothingList.dart';
import 'package:miaged/pages/home.dart';
import 'package:miaged/pages/shoppingBasket.dart';
import 'package:miaged/services/userService.dart';

import '../services/clothingService.dart';

class DetailClothingWidget extends StatelessWidget {
  final String idClothing;

  const DetailClothingWidget({super.key, required this.idClothing});

  @override
  Widget build(BuildContext context) {
    void returnToListClothing() {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ClothingListWidget(
                  wantedNavigation: 'buy',
                )),
      );
    }

    void addToShoppingBasket() {
      UserService.addToBasket(idClothing);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const ClothingListWidget(wantedNavigation: "shoppingBasket")),
      );
    }

    return FutureBuilder(
      future: ArticleService.getArticle(idClothing),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Scaffold(
              body: Center(
            child: ListView(
              children: [
                Image.network(data.photoUrl),
                Text(" nom: ${data.name}"),
                Text(" taille: ${data.size}"),
                Text(" marque: ${data.brand}"),
                Text(" prix: ${data.price.toString()}"),
                TextButton(
                    onPressed: returnToListClothing,
                    child: const Text("Retour")),
                TextButton(
                  onPressed: addToShoppingBasket,
                  child: const Text("Ajouter au panier"),
                )
              ],
            ),
          ));
        } else if (snapshot.hasError) {
          // Gestion des erreurs ici
          return Scaffold(
            appBar: AppBar(
              title: const Text('Erreur de connexion'),
            ),
            body: Center(
              child: Text('Erreur: ${snapshot.error}'),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
