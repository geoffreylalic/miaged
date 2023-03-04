import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShoppingBasketWidget extends StatefulWidget {
  const ShoppingBasketWidget({super.key});

  @override
  State<ShoppingBasketWidget> createState() => _ShoppingBasketWidgetState();
}

class _ShoppingBasketWidgetState extends State<ShoppingBasketWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Panier'),
    );
  }
}
