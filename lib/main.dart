import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/posts_screen/post_bloc/post_bloc.dart';
import 'package:tp_flutter/posts_screen/post_create_screen.dart';
import 'package:tp_flutter/posts_screen/post_list_bloc/post_list_bloc.dart';
import 'package:tp_flutter/posts_screen/posts_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tp_flutter/repository/app_repository.dart';
import 'package:tp_flutter/repository/firebase_data_source/firebase_data_source.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AppRepository(remoteDataSource: FirestoreDataSource()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>PostBloc()),
          BlocProvider(create: (context)=>PostListBloc(
            appRepository: context.read<AppRepository>(),
          )),
        ],
        child: MaterialApp(
          title: 'TP Flutter',
          home: const PostsScreen(),
          routes: {
            CreatePostScreen.routeName: (context) => const CreatePostScreen(),

          },
        ),
      ),
    );
  }
}