import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/clothingList.dart';
import '../services/userService.dart';

class CarteArticle extends StatelessWidget {
  final String? id;
  final String? name;
  final int? price;
  final String? size;
  final String? photoUrl;
  final bool? isBasketArticle;
  final Function(bool)? deleteCallback;

  const CarteArticle({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.photoUrl,
    required this.isBasketArticle,
    this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        // margin: const EdgeInsets.all(10),
        child: SizedBox(
          height: 200,
          width: 100,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Expanded(
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(4),
              //       topRight: Radius.circular(4),
              //     ),
              //     child: Image.network(
              //       photoUrl!,
              //       // fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              isBasketArticle == true
                  ? IconButton(
                      onPressed: () {
                        UserService.removeFromBasket(id);
                        deleteCallback!(true);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const ClothingListWidget(
                        //             wantedNavigation: 'shoppingBasket')));
                      },
                      icon: const Icon(Icons.delete))
                  : Container(),
              Image.network(
                photoUrl!,
                fit: BoxFit.cover,
                width: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "prix: ${price.toString()} €",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "taille: ${size!}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
