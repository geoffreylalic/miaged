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
        price: int.parse(data['price']),
      );
      articles.add(article);
    }
    return articles;
  }
}
