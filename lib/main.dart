import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/posts_screen/post_bloc/post_bloc.dart';
import 'package:tp_flutter/posts_screen/post_list_bloc/post_list_bloc.dart';
import 'package:tp_flutter/posts_screen/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>PostBloc()),
        BlocProvider(create: (context)=>PostListBloc()),
      ],
      child: const MaterialApp(
        title: 'TP Flutter',
        home: PostsScreen(),
        routes: {
          PostCreateScreen.routeName: (context) => const PostCreateScreen(),
        },
      ),
    );
  }
}