class SignUpRequestWithEmail {
  final String username;
  final String email;
  final String mobileNumber;
  final String password;

  SignUpRequestWithEmail({
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.password,
  });

  factory SignUpRequestWithEmail.fromJson(Map<String, dynamic> json) {
    return SignUpRequestWithEmail(
        username: json['username'],
        email: json['email'],
        password: json['password'],
        mobileNumber: json['mobile_number']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'mobile_number': mobileNumber,
    };
  }
}
