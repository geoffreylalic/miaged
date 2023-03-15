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

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late List<ClothingModel> _data = [];
  final TextEditingController _controller = TextEditingController();
  late bool _isLoading = false;
  late String _filter = "";
  late String _category = "";
  final List<Tab> _tabs = [
    const Tab(text: "Tous"),
    const Tab(text: "Hauts & t-shirts"),
    const Tab(text: "Sweats & pulls"),
    const Tab(text: "Pantalons"),
    const Tab(text: "Robes"),
    const Tab(text: "Accessoires"),
    const Tab(text: "Chaussures"),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _tabController = TabController(length: 7, vsync: this);
    ArticleService.getArticles("", "").then(
      (value) {
        setState(() {
          _data = value;
          _isLoading = false;
        });
      },
    );
  }

  void refreshCategory(category) {
    setState(() {
      _category = category;
      _data = [];
      _isLoading = true;
    });
    ArticleService.getArticles(_filter, _category).then(
      (value) {
        setState(() {
          _data = value;
          _isLoading = false;
        });
      },
    );
  }

  void _filterItem(int index) {
    setState(() {
      switch (index) {
        case 0:
          refreshCategory("");
          break;
        case 1:
          refreshCategory("Hauts & t-shirts");
          break;
        case 2:
          refreshCategory("Sweats & pulls");
          break;
        case 3:
          refreshCategory("Pantalons");
          break;
        case 4:
          refreshCategory("Robes");
          break;
        case 5:
          refreshCategory("Accessoires");
          break;
        case 6:
          refreshCategory("Chaussures");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        appBar: TabBar(
          controller: _tabController,
          tabs: _tabs,
          onTap: _filterItem,
          isScrollable: true,
          labelStyle: const TextStyle(fontSize: 20),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
        ),
        body: SafeArea(
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
                        setState(() {
                          _filter = value;
                        });
                        ArticleService.getArticles(_filter, _category)
                            .then((value) {
                          setState(() {
                            _data = [];
                            _data = value;
                          });
                        });
                      },
                    )),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                    child: GridView(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      builder: (context) =>
                                          DetailClothingWidget(
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
        )));
  }
}
