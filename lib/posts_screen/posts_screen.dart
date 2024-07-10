
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/posts_screen/post_bloc/post_bloc.dart';
import 'package:tp_flutter/posts_screen/post_create_screen.dart';
import 'package:tp_flutter/posts_screen/post_detail_screen/post_detail_screen.dart';
import 'package:tp_flutter/posts_screen/post_list_bloc/post_list_bloc.dart';

import 'models/post.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();

    _getAllPosts();
  }

  void _getAllPosts() async {
      context.read<PostListBloc>().add(GetAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc,PostsState>(
      listener: _onPostBlocListener,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
        ),
        body: BlocBuilder<PostListBloc, PostsListState>(
          builder: (context, state) {
            final posts = state.posts;

            if (state.status == PostsListStatus.gettingAllPosts) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.status == PostsListStatus.errorGettingPost) {
              return const Center(
                child: Text('Oups, une erreur est survenue'),
              );
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.name),
                  subtitle: Text(post.description),
                  onTap: () => _onPostTap(post),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onCreatePostTap(context),
          child: const Icon(Icons.add),
        )
      ),
    );
  }

  void _onPostBlocListener(BuildContext context, PostsState state) {
    if (state.status == PostsStatus.errorCreatingPost) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            icon: Icon(Icons.error),
            title: Text('Erreur de création'),
          );
        },
      );
    }
  }

  void _onPostTap(Post post) {
    PostDetailScreen.navigateTo(context,post);
  }

  void _onCreatePostTap(BuildContext context) {
    CreatePostScreen.navigateTo(context);
  }
}


