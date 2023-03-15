import 'package:flutter/material.dart';

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
    super.key,
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
        child: SizedBox(
          child: Column(
            children: [
              isBasketArticle == true
                  ? IconButton(
                      onPressed: () {
                        deleteCallback!(true);
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    )
                  : Container(),
              Flexible(
                child: Image.network(
                  photoUrl!,
                  fit: BoxFit.cover,
                  // width: 100,
                ),
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
