part of 'post_bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent();
}

class CreatePost extends PostEvent {
  final Post post;

  const CreatePost({required this.post});
}

class UpdatePost extends PostEvent {
  final Post post;

  const UpdatePost({required this.post});
}