import 'package:finding_apartments_yangon/features/data/models/social_contact.dart';

class MyUser {
  int? id;
  String? username;
  String? profileUrl;
  String? mobileNumber;
  String? email;
  List<SocialContact>? socialContacts;

  MyUser({
    this.id,
    this.username,
    this.profileUrl,
    this.mobileNumber,
    this.email,
    this.socialContacts,
  });
  factory MyUser.fromJson(Map<String, dynamic> json) {
    List<SocialContact> socialContactsList =
        (json['social_contacts'] as List? ?? [])
            .map((contact) => SocialContact.fromJson(contact))
            .toList();

    return MyUser(
      id: json['id'] as int?,
      username: json['username'] as String?,
      profileUrl: json['profile_url'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      email: json['email'] as String?,
      socialContacts: socialContactsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profile_url': profileUrl,
      'mobile_number': mobileNumber,
      'email': email,
      'social_contacts': socialContacts,
    };
  }
}
