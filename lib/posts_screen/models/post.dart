
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String? id;
  final String name;
  final String description;

  const Post({
    this.id,
    required this.name,
    required this.description,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['title'],
      description: json['description'],
    );
  }

  @override
  List<Object?> get props => [id];
}
