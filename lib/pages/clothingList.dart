import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClothingListWidget extends StatefulWidget {
  const ClothingListWidget({super.key, this.title});
  final title;

  @override
  State<ClothingListWidget> createState() => _ClothingListWidgetState();
}

class _ClothingListWidgetState extends State<ClothingListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        else return Text('Paul burel');
      },
    );
  }
}