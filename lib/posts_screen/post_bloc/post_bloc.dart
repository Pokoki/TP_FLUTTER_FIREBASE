import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/app_repository.dart';
import '../models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostsState> {

  final AppRepository appRepository;
  PostBloc({required this.appRepository}) : super(const PostsState()) {
    on<CreatePost>(_onCreatePost);
    on<UpdatePost>(_onUpdatePost);
  }

  void _onCreatePost(CreatePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.creatingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try{
      await appRepository.createPost(post);
      await appRepository.getAllPosts();
      emit(state.copyWith(
        status: PostsStatus.successCreatePost,
        post: post,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: PostsStatus.errorCreatingPost,
        error: e,
      ));
    }
  }

  void _onUpdatePost(UpdatePost event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.updatingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

    try{
      await appRepository.updatePost(post);
      await appRepository.getAllPosts();
      emit(state.copyWith(
        status: PostsStatus.successUpdatePost,
        post: post,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: PostsStatus.errorUpdatingPost,
        error: e,
      ));
    }
  }

}
