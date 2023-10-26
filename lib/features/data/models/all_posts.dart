import 'package:finding_apartments_yangon/features/data/models/post.dart';

class AllPosts {
  List<Post>? postList;
  String? cursor;
  bool? hasNext;

  AllPosts({
    this.postList,
    this.cursor,
    this.hasNext,
  });

  factory AllPosts.fromJson(Map<String, dynamic> json) {
    List<Post> postList = (json['posts'] as List? ?? [])
        .map((post) => Post.fromJson(post))
        .toList();

    return AllPosts(
      postList: postList,
      cursor: json['cursor'] as String?,
      hasNext: json['has_next'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posts': postList,
      'cursor': cursor,
      'has_next': hasNext,
    };
  }
}
