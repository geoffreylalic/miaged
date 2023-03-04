import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarteArticle extends StatelessWidget {
  final String? id;
  final String? name;
  final int? price;
  final String? size;
  final String? photoUrl;

  CarteArticle({
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      // margin: const EdgeInsets.all(10),
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
          Image.network(photoUrl!),
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
                  price.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  size!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}