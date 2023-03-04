import 'package:flutter/material.dart';
import 'package:miaged/pages/profile.dart';
import 'package:miaged/pages/shoppingBasket.dart';

import '../widgets/customButtomAppBar.dart';
import 'home.dart';

class ClothingListWidget extends StatefulWidget {
  const ClothingListWidget({super.key});

  @override
  State<ClothingListWidget> createState() => _ClothingListWidgetState();
}

class _ClothingListWidgetState extends State<ClothingListWidget> {
  late String _navigation = "buy";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miaged'),
      ),
      body: _navigation == "buy"
          ? const HomeWidget()
          : _navigation == "shoppingBasket"
              ? const ShoppingBasketWidget()
              : _navigation == "profile"
                  ? const ProfileWidget()
                  : const HomeWidget(),
      bottomNavigationBar: CustomBottomAppBar(
        onNavigationChanged: (String data) {
          setState(() {
            _navigation = data;
          });
        },
      ),
    );
  }
}
