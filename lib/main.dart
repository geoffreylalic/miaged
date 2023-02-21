import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/pages/authentication/login.dart';
import 'package:miaged/pages/authentication/register.dart';
import 'package:miaged/pages/clothingList.dart';
import 'package:miaged/pages/home.dart';
import 'package:miaged/pages/search.dart';
import 'package:miaged/widgets/customButtomAppBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIAGED',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _navigation = "home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Rechercher un article ou un membre',
                border: InputBorder.none),
          ),
        ),
      )),
      body: _navigation == "home" ? HomeWidget() : SearchWidget(),
      bottomNavigationBar: CustomBottomAppBar(
        onNavigationChanged: (String data) {
          setState(() {
            _navigation = data;
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Home()));
          });
        },
      ),
    );
  }
}
