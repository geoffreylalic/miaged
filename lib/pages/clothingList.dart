import 'package:flutter/material.dart';

class ClothingListWidget extends StatefulWidget {
  const ClothingListWidget({super.key});

  @override
  State<ClothingListWidget> createState() => _ClothingListWidgetState();
}

class _ClothingListWidgetState extends State<ClothingListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return const Divider();
        } else {
          return const Image(
            image: NetworkImage(
                'https://media.tenor.com/dxiNcLo5hQIAAAAd/edp-i-mean-its-alright.gif'),
          );
        }
      },
    );
  }
}