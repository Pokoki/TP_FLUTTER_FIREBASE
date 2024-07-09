part of 'post_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  creatingPost,
  updatingPost,
  successCreatePost,
  successUpdatePost,
  errorCreatingPost,
  errorUpdatingPost,
}

class PostsState {
  final PostsStatus status;
  final Post? post;
  final Exception? error;

  const PostsState({
    this.status = PostsStatus.initial,
    this.post,
    this.error,
  });

  PostsState copyWith({
    PostsStatus? status,
    Post? post,
    Exception? error,
  }) {
    return PostsState(
      status: status ?? this.status,
      post: post ?? this.post,
      error: error ?? this.error,
    );
  }
}
