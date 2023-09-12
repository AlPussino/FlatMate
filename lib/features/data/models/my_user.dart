import 'package:finding_apartments_yangon/features/data/models/social_contact.dart';

class MyUser {
  int? id;
  String? username;
  String? profileUrl;
  String? mobileNumber;
  String? email;
  SocialContact? socialContacts;

  MyUser({
    this.id,
    this.username,
    this.profileUrl,
    this.mobileNumber,
    this.email,
    this.socialContacts,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      id: json['id'] as int?,
      username: json['username'] as String?,
      profileUrl: json['profileUrl'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      socialContacts: json['social_contacts'] != null
          ? SocialContact.fromJson(json['social_contacts'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profileUrl': profileUrl,
      'mobileNumber': mobileNumber,
      'email': email,
      'social_contacts': socialContacts!.toJson(),
    };
  }
}
