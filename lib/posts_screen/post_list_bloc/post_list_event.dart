part of 'post_list_bloc.dart';

@immutable
sealed class PostListEvent {
  const PostListEvent();
}

class GetAllPosts extends PostListEvent {}

class AddPost extends PostListEvent {
  final Post post;

  const AddPost({required this.post});
}

class RemovePost extends PostListEvent {
  final Post post;

  const RemovePost({required this.post});
}