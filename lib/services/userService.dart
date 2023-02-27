import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User?> createUserWithEmailAndPassword(
    String email, String password) async {
  final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  final User? user = userCredential.user;
  print(user);
  return user;
}

Future<User?> signInWithEmailAndPassword(
    String email, String password) async {
  final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  final User? user = userCredential.user;
  return user;
}
