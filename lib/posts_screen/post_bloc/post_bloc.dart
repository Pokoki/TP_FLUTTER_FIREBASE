import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostsState> {
  PostBloc() : super(const PostsState()) {
    on<GetAllPosts>(_onGetAllPosts);
  }

  void _onGetAllPosts(GetAllPosts event, Emitter<PostsState> emit) async {
    emit(state.copyWith(status: PostsStatus.loading));
    try {
      final products = await _getAllPosts();
      emit(state.copyWith(
        status: PostsStatus.success,
        products: products,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostsStatus.error,
        error: Exception(),
      ));
    }
  }

  Future<List<Post>> _getAllPosts() async {
    //METTRE APPEL API
    await Future.delayed(const Duration(seconds: 2));
    return List.generate(10, (index) {
      return Post(
        id: index,
        name: 'Product $index',
        description: 'Description $index',
      );
    });
  }
}
