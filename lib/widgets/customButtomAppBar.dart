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
  late String _navigation = "home";

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
          tooltip: 'Home',
          icon: _navigation == 'home'
              ? (const Icon(Icons.home))
              : (const Icon(Icons.home_outlined)),
          onPressed: () {
            setState(() {
              _navigation = 'home';
              widget.onNavigationChanged(_navigation);
            });
          },
        ),
        IconButton(
          tooltip: 'Search',
          icon: _navigation == 'search'
              ? const Icon(Icons.search_rounded)
              : const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _navigation = 'search';
              widget.onNavigationChanged(_navigation);
            });
          },
        ),
        IconButton(
          tooltip: 'Sell',
          icon: _navigation == 'sell'
              ? const Icon(Icons.add_circle)
              : const Icon(Icons.add_circle_outline),
          onPressed: () {
            setState(() {
              _navigation = 'sell';
              widget.onNavigationChanged(_navigation);
            });
          },
        ),
        IconButton(
          tooltip: 'Messages',
          icon: _navigation == 'messages'
              ? const Icon(Icons.email)
              : const Icon(Icons.email_outlined),
          onPressed: () {
            setState(() {
              _navigation = 'messages';
              widget.onNavigationChanged(_navigation);
            });
          },
        ),
        IconButton(
          tooltip: 'Profile',
          icon: _navigation == 'profil'
              ? const Icon(Icons.person)
              : const Icon(Icons.person_outline),
          onPressed: () {
            setState(() {
              _navigation = 'profil';
              widget.onNavigationChanged(_navigation);
            });
          },
        ),
      ],
    );
  }
}
