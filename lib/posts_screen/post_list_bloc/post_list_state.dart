part of 'post_list_bloc.dart';

enum PostsListStatus {
  initial,

  gettingAllPosts,
  addingPost,
  updatingPost,

  successAddingPost,
  successUpdatingPost,
  successGettingPost,

  errorAddingPost,
  errorUpdatingPost,
  errorGettingPost,
}


class PostsListState {
  final PostsListStatus status;
  final List<Post> posts;
  final Exception? error;

  const PostsListState({
    this.status = PostsListStatus.initial,
    this.posts = const [],
    this.error,
  });

  PostsListState copyWith({
    PostsListStatus? status,
    List<Post>? posts,
    Exception? error,
  }) {
    return PostsListState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}