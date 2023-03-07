import 'package:flutter/material.dart';
import 'package:miaged/services/userService.dart';

import '../models/clothing.dart';
import '../services/clothingService.dart';
import '../widgets/carteArticle.dart';

class ShoppingBasketWidget extends StatefulWidget {
  const ShoppingBasketWidget({super.key});

  @override
  State<ShoppingBasketWidget> createState() => _ShoppingBasketWidgetState();
}

class _ShoppingBasketWidgetState extends State<ShoppingBasketWidget> {
  late Future<List<ClothingModel>> _basketFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _basketFuture = _getBasket();
  }

  void _refreshBasket(bool isDeleted) {
    setState(() {
      _basketFuture = _getBasket();
      print("refreshed ----");
    });
  }

  Future<List<ClothingModel>> _getBasket() async {
    return UserService.getBasket();
  }

  int _getTotal(List<ClothingModel> data) {
    var res = 0;
    for (var el in data) {
      res += el.price!;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _basketFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data.length == 0) {
            return Text("Votre panier est vide.");
          }
          for (var element in data);
          return ListView(children: [
            for (var element in data)
              CarteArticle(
                id: element.id,
                name: element.name,
                price: element.price,
                size: element.size,
                photoUrl: element.photoUrl,
                isBasketArticle: true,
                deleteCallback: _refreshBasket,
              ),
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomCenter,
              child: Text("Total: ${_getTotal(data)} €"),
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
