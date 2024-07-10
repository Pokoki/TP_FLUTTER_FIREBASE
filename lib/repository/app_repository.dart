import '../posts_screen/models/post.dart';
import 'firebase_data_source/remote_data_source.dart';

class AppRepository {
  final RemoteDataSource remoteDataSource;

  AppRepository({
    required this.remoteDataSource,
  });

  Future<List<Post>> getAllPosts() async {
    return remoteDataSource.getAllPosts();
  }

  Future<Post> createPost(Post post) async {
    return remoteDataSource.createPost(post);
  }

  Future<void> updatePost(Post post) async {
    return remoteDataSource.updatePost(post);
  }

  Future<void> removePost(Post post) async {
    return remoteDataSource.removePost(post);
  }
}