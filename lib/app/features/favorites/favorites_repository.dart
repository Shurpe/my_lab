import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/domain/repositories/content/model/content.dart';

class FavoritesRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _favorites =>
      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('favorites');

  Future<List<Content>> getFavorites() async {
    final snapshot = await _favorites.get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Content(
        id: data['id'],
        title: data['title'],
        description: data['description'],
        image: data['image'],
        author: '',
      );
    }).toList();
  }

  Future<void> addToFavorites(Content content) async {
    await _favorites.doc(content.id.toString()).set({
      'id': content.id,
      'title': content.title,
      'description': content.description,
      'image': content.image,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFromFavorites(int id) async {
    await _favorites.doc(id.toString()).delete();
  }

  Future<bool> isFavorite(int id) async {
    final doc = await _favorites.doc(id.toString()).get();
    return doc.exists;
  }
}
