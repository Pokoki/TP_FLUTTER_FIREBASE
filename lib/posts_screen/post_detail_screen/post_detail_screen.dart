import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter/posts_screen/models/post.dart';

import '../post_bloc/post_bloc.dart';
import '../post_list_bloc/post_list_bloc.dart';

class PostDetailScreen extends StatefulWidget {
  static const routeName = 'postDetailScreen';

  static Future<void> navigateTo(BuildContext context, Post post) {
    return Navigator.of(context).pushNamed(routeName, arguments: post);
  }

  const PostDetailScreen({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.post.name);
    _descriptionController = TextEditingController(text: widget.post.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _onUpdateTap(context),
              child: const Text('Modifier'),
            ),
          ],
        ),
      ),
    );
  }

  void _onUpdateTap(BuildContext context) {
    final updatedPost = Post(
      id: widget.post.id,
      name: _nameController.text,
      description: _descriptionController.text,
    );

    context.read<PostBloc>().add(UpdatePost(post: updatedPost));
    Navigator.of(context).pop();
  }
}
