import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged/pages/clothingList.dart';
import 'package:miaged/pages/home.dart';
import 'package:miaged/pages/shoppingBasket.dart';

import '../services/clothingService.dart';

class DetailClothingWidget extends StatelessWidget {
  final String idClothing;

  const DetailClothingWidget({super.key, required this.idClothing});

  @override
  Widget build(BuildContext context) {
    void returnToListClothing() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ClothingListWidget(wantedNavigation: 'buy',)),
      );
    }

    void addToShoppingBasket() {
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
          print("on est la ");
          print(data.runtimeType);
          print(data.toString());
          print(data.name);
          return Container(
              child: ListView(
            children: [
              Image.network(data.photoUrl),
              Text(" name: ${data.name}"),
              Text(" size: ${data.size}"),
              Text(" brand: ${data.brand}"),
              Text(" price: ${data.price.toString()}"),
              TextButton(
                  onPressed: returnToListClothing, child: const Text("Retour")),
              TextButton(
                onPressed: addToShoppingBasket,
                child: const Text("Ajouter au panier"),
              )
            ],
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
