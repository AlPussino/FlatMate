class SocialContact {
  int? id;
  String? username;
  String? profileUrl;
  String? contactType;

  SocialContact({
    this.id,
    this.username,
    this.profileUrl,
    this.contactType,
  });

  factory SocialContact.fromJson(Map<String, dynamic> json) {
    return SocialContact(
      id: json['id'] as int?,
      username: json['username'] as String?,
      profileUrl: json['url'] as String?,
      contactType: json['contact_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'url': profileUrl,
      'contact_type': contactType,
    };
  }
}
