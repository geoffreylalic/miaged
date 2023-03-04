import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaged/firebase_options.dart';
import 'package:miaged/pages/authentication/completeProfile.dart';
import 'package:miaged/pages/authentication/login.dart';
import 'package:miaged/pages/authentication/register.dart';
import 'package:miaged/pages/clothingList.dart';
import 'package:miaged/pages/home.dart';
import 'package:miaged/widgets/customButtomAppBar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const ClothingListWidget(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
