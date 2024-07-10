import '../../posts_screen/models/post.dart';

abstract class RemoteDataSource {
  Future<List<Post>> getAllPosts();
  Future<Post> createPost(Post post);
  Future<void> updatePost(Post post);
  Future<void> removePost(Post post);
}