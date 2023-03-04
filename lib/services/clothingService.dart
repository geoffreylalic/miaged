import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clothing.dart';

class ArticleService {
  static Future<List<ClothingModel>> getArticles() async {
    final articles = <ClothingModel>[];
    final querySnapshot =
        await FirebaseFirestore.instance.collection('clothings').get();
    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final article = ClothingModel(
        id: doc.id,
        name: data['name'],
        photoUrl: data['photoUrl'],
        size: data['size'],
        price: data['price'],
      );
      articles.add(article);
    }
    return articles;
  }

  static Future<ClothingModel> getArticle(String id) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('clothings').doc(id).get();
    var data = snapshot.data();
    ClothingModel article = ClothingModel(
      id: id,
      name: data!["name"],
      brand: data["brand"],
      size: data["size"],
      price: data["price"],
      photoUrl: data["photoUrl"],
    );
    return article;
  }
}
