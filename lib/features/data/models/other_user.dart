import 'package:finding_apartments_yangon/features/data/models/post.dart';
import 'package:finding_apartments_yangon/features/data/models/social_contact.dart';

class OtherUser {
  int? id;
  String? username;
  String? profileUrl;
  String? mobileNumber;
  List<SocialContact>? socialContacts;
  List<Post>? postList;

  OtherUser({
    this.id,
    this.username,
    this.profileUrl,
    this.mobileNumber,
    this.socialContacts,
    this.postList,
  });
  factory OtherUser.fromJson(Map<String, dynamic> json) {
    List<Post> postsList = (json['posts'] as List? ?? [])
        .map((post) => Post.fromJson(post))
        .toList();

    List<SocialContact> socialContactsList =
        (json['social_contacts'] as List? ?? [])
            .map((contact) => SocialContact.fromJson(contact))
            .toList();

    return OtherUser(
      id: json['id'] as int?,
      username: json['username'] as String?,
      profileUrl: json['profile_url'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      socialContacts: socialContactsList,
      postList: postsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profile_url': profileUrl,
      'mobile_number': mobileNumber,
      'social_contacts': socialContacts,
      'posts': postList,
    };
  }
}
