class AddSocialContactRequest {
  final String userName;
  final String url;
  final String contactType;

  AddSocialContactRequest({
    required this.userName,
    required this.url,
    required this.contactType,
  });

  factory AddSocialContactRequest.fromJson(Map<String, dynamic> json) {
    return AddSocialContactRequest(
        userName: json['username'] as String,
        url: json['url'] as String,
        contactType: json['contact_type'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
      'url': url,
      'contact_type': contactType,
    };
  }
}
