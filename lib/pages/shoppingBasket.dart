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
    _basketFuture = UserService.getBasket();
  }

  void refreshBasket(bool isDeleted) {
    setState(() {
      _basketFuture = UserService.getBasket();
      print("state ${_basketFuture}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: UserService.getBasket(),
      future: _basketFuture,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          for (var element in data) print(element);
          return ListView(children: [
            for (var element in data)
              CarteArticle(
                id: element.id,
                name: element.name,
                price: element.price,
                size: element.size,
                photoUrl: element.photoUrl,
                isBasketArticle: true,
                deleteCallback: refreshBasket,
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
