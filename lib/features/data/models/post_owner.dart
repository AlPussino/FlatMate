class PostOwner {
  int? id;
  String? username;
  String? mobileNumber;
  String? profileUrl;

  PostOwner({
    this.id,
    this.username,
    this.mobileNumber,
    this.profileUrl,
  });

  factory PostOwner.fromJson(Map<String, dynamic> json) {
    return PostOwner(
      id: json['id'] as int?,
      username: json['username'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      profileUrl: json['profile_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'mobile_number': mobileNumber,
      'profile_url': profileUrl,
    };
  }
}
