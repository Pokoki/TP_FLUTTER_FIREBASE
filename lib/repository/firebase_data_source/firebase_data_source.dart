

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_flutter/repository/firebase_data_source/remote_data_source.dart';

import '../../posts_screen/models/post.dart';

class FirestoreDataSource extends RemoteDataSource {
  @override
  Future<List<Post>> getAllPosts() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('posts').get();
      final posts = querySnapshot.docs.map((doc) {
        return Post(
          id: doc.id,
          name: doc.data()['name'] as String,
          description: doc.data()['description'] as String,
        );
      }).toList();
      return posts;
    } catch (e) {
      throw Exception('Error fetching posts : $e');
    }
  }

  @override
  Future<Post> createPost(Post post) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance.collection('posts').add({
        'name': post.name,
        'description': post.description,
      });
      return Post(id: docRef.id, name: post.name, description: post.description);
    } catch (e) {
      throw Exception( 'Failed to add post: $e');
    }
  }

  @override
  Future<void> updatePost(Post post) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(post.id).update({
        'name': post.name,
        'description': post.description,
      });
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  @override
  Future<void> removePost(Post post) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(post.id).delete();
    } catch (e) {
      throw Exception('Failed to remove post: $e');
    }
  }
}