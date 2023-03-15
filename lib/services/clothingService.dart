import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clothing.dart';

class ArticleService {
  static Future<List<ClothingModel>> getArticles(
      String filter, String category) async {
    print("filter ----- $filter, $category");
    final articles = <ClothingModel>[];
    Query query = FirebaseFirestore.instance.collection('clothings');
    if (category != "" && filter == "") {
      query = query.where('category', isEqualTo: category);
    }
    if (filter != "" && category == "") {
      query = query
          .where('name', isGreaterThanOrEqualTo: filter)
          .where('name', isLessThanOrEqualTo: filter + '\uf8ff');
    }
    if (category != "" && filter != "") {
      query = query
          .where('category', isEqualTo: category)
          .where('name', isGreaterThanOrEqualTo: filter)
          .where('name', isLessThanOrEqualTo: filter + '\uf8ff');
    }
    // if (category == "" && filter == "") {
    //   query = FirebaseFirestore.instance.collection('clothings');
    // }
    final querySnapshot = await query.get();
    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final article = ClothingModel(
        id: doc.id,
        name: doc["name"],
        photoUrl: doc["photoUrl"],
        size: doc['size'],
        price: doc["price"],
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
