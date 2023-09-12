class LogInRequestWithEmail {
  final String email;
  final String password;

  LogInRequestWithEmail({
    required this.email,
    required this.password,
  });

  factory LogInRequestWithEmail.fromJson(Map<String, dynamic> json) {
    return LogInRequestWithEmail(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
