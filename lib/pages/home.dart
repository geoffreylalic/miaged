import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged/models/clothing.dart';
import 'package:miaged/pages/authentication/completeProfile.dart';
import 'package:miaged/pages/detailClothing.dart';
import 'package:miaged/widgets/carteArticle.dart';

import '../services/clothingService.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late List<ClothingModel> _data = [];
  final TextEditingController _controller = TextEditingController();
  late bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    ArticleService.getArticles("").then(
      (value) {
        setState(() {
          _data = value;
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: CircularProgressIndicator(),
      );
    }
    return SafeArea(
        child: GestureDetector(
      child: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Recherche',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                      },
                    ),
                  ),
                  onChanged: (value) {
                    ArticleService.getArticles(value).then((value) {
                      print("value------ $value");
                      setState(() {
                        _data = value;
                      });
                    });
                  },
                )),
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
                      GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailClothingWidget(
                                        idClothing: card.id as String,
                                      ))),
                          child: CarteArticle(
                            id: card.id,
                            isBasketArticle: false,
                            name: card.name,
                            photoUrl: card.photoUrl,
                            price: card.price,
                            size: card.size,
                          ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
