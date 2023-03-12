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
  late List<ClothingModel> _data = [];
  late bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getBasket();
  }

  void _getBasket() {
    print("_get baskket --- triggred -");
    setState(() {
      _isLoading = true;
    });
    UserService.getBasket().then(((value) {
      setState(() {
        _data = value;
        _isLoading = false;
      });
    }));
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
    if (_isLoading) {
      return const Scaffold(
        body: CircularProgressIndicator(),
      );
    }
    if (_data.isEmpty) {
      return const Text("Votre panier est vide.");
    }
    return SafeArea(
        child: GestureDetector(
      child: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    for (var card in _data)
                      CarteArticle(
                        id: card.id,
                        name: card.name,
                        price: card.price,
                        size: card.size,
                        photoUrl: card.photoUrl,
                        isBasketArticle: true,
                        deleteCallback: ((_) {
                          _getBasket();
                        }),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomCenter,
              child: Text("Total: ${_getTotal(_data)} €"),
            ),
          ],
        ),
      ),
    ));
  }
}
