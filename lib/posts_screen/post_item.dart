import 'package:flutter/material.dart';
import 'package:tp_flutter/posts_screen/models/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
    this.onTap
  });

  final Post post;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.name),
      subtitle: Text(post.description),
      onTap: onTap,
    );

  }
}
