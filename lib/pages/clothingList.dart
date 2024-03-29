import 'package:flutter/material.dart';
import 'package:miaged/pages/profile.dart';
import 'package:miaged/pages/shoppingBasket.dart';

import '../widgets/customButtomAppBar.dart';
import 'home.dart';

class ClothingListWidget extends StatefulWidget {
  final String wantedNavigation;
  const ClothingListWidget({super.key, required this.wantedNavigation});

  @override
  State<ClothingListWidget> createState() => _ClothingListWidgetState();
}

class _ClothingListWidgetState extends State<ClothingListWidget> {
  late String _navigation = "buy";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.wantedNavigation != null || widget.wantedNavigation.isNotEmpty) {
      _navigation = widget.wantedNavigation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miaged'),
        automaticallyImplyLeading: false,
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
