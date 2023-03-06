import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged/models/clothing.dart';
import 'package:miaged/pages/authentication/completeProfile.dart';
import 'package:miaged/pages/detailClothing.dart';
import 'package:miaged/widgets/carteArticle.dart';

import '../services/clothingService.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late List<ClothingModel> _data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ArticleService.getArticles(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;

          return ListView(children: [
            for (var element in data)
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailClothingWidget(
                              idClothing: element.id,
                            ))),
                child: CarteArticle(
                  id: element.id,
                  name: element.name,
                  price: element.price,
                  size: element.size,
                  photoUrl: element.photoUrl,
                  isBasketArticle: false,
                ),
              )
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
