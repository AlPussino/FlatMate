import 'dart:convert';
import 'package:finding_apartments_yangon/features/data/models/post_owner.dart';

class PostOwnerList {
  final List<PostOwner>? postOwners;

  PostOwnerList({
    this.postOwners,
  });

  factory PostOwnerList.fromJson(String jsonStr) {
    final jsonData = jsonDecode(jsonStr) as List<dynamic>;
    List<PostOwner> postOwnerList =
        jsonData.map((postOwner) => PostOwner.fromJson(postOwner)).toList();
    return PostOwnerList(postOwners: postOwnerList);
  }

  String toJson() {
    final jsonData =
        postOwners!.map((postOwner) => postOwner.toJson()).toList();
    return jsonEncode(jsonData);
  }
}
