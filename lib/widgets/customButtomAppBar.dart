import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomBottomAppBar extends StatefulWidget {
  final void Function(String) onNavigationChanged;

  const CustomBottomAppBar({
    required this.onNavigationChanged,
  });

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  late String _navigation = "buy";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          tooltip: 'Acheter',
          icon: _navigation == 'buy'
              ? Icon(
                  Icons.store,
                  color: Colors.blue.shade400,
                )
              : (const Icon(Icons.store_outlined)),
          onPressed: () {
            setState(() {
              _navigation = 'buy';
              widget.onNavigationChanged(_navigation);
            });
          },
        ),
        IconButton(
          tooltip: 'Panier',
          icon: _navigation == 'shoppingBasket'
              ? Icon(
                  Icons.shopping_basket,
                  color: Colors.blue.shade400,
                )
              : const Icon(Icons.shopping_basket_outlined),
          onPressed: () {
            setState(() {
              _navigation = 'shoppingBasket';
              widget.onNavigationChanged(_navigation);
            });
          },
        ),
        IconButton(
          tooltip: 'Profile',
          icon: _navigation == 'profile'
              ? Icon(
                  Icons.person,
                  color: Colors.blue.shade400,
                )
              : const Icon(Icons.person_outlined),
          onPressed: () {
            setState(() {
              _navigation = 'profile';
              widget.onNavigationChanged(_navigation);
            });
          },
        ),
      ],
    );
  }
}
