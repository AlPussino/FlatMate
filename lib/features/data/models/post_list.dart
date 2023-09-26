import 'dart:convert';
import 'package:finding_apartments_yangon/features/data/models/post.dart';

class PostList {
  final List<Post>? posts;

  PostList({
    this.posts,
  });

  factory PostList.fromJson(String jsonStr) {
    final jsonData = jsonDecode(jsonStr) as List<dynamic>;
    List<Post> postList = jsonData.map((post) => Post.fromJson(post)).toList();
    return PostList(posts: postList);
  }

  String toJson() {
    final jsonData = posts!.map((post) => post.toJson()).toList();
    return jsonEncode(jsonData);
  }
}
