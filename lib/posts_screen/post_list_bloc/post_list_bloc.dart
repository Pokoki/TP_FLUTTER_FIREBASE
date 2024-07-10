import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/app_repository.dart';
import '../models/post.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostsListState> {
  final AppRepository appRepository;
  PostListBloc({required this.appRepository}) : super(const PostsListState()) {
      on<AddPost>(_onAddPost);
      on<GetAllPosts>(_onGetAllPosts);
  }

  void _onAddPost(AddPost event, Emitter<PostsListState> emit) async {
    emit(state.copyWith(status: PostsListStatus.addingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostsListState> emit) async {
    emit(state.copyWith(status: PostsListStatus.gettingAllPosts));
    try {
      final posts = await appRepository.getAllPosts();
      emit(state.copyWith(
        status: PostsListStatus.successGettingPost,
        posts: posts,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsListStatus.errorGettingPost,
        error: Exception(),
      ));
    }
  }
}
