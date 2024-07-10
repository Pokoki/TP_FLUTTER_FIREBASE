import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/post.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostsListState> {
  PostListBloc() : super(const PostsListState()) {
      on<AddPost>(_onAddPost);
  }

  void _onAddPost(AddPost event, Emitter<PostsListState> emit) async {
    emit(state.copyWith(status: PostsListStatus.addingPost));
    final post = event.post;
    await Future.delayed(const Duration(seconds: 1));

  }
}
