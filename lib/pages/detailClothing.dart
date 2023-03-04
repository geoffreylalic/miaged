import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailClothingWidget extends StatelessWidget {
  final String idClothing;

  const DetailClothingWidget({super.key, required this.idClothing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma page suivante'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Paramètre 1 : $idClothing'),
          ],
        ),
      ),
    );
  }
}
