class LogInRequestWithEmail {
  final String email;
  final String password;
  final String deviceId;

  LogInRequestWithEmail({
    required this.email,
    required this.password,
    required this.deviceId,
  });

  factory LogInRequestWithEmail.fromJson(Map<String, dynamic> json) {
    return LogInRequestWithEmail(
      email: json['email'],
      password: json['password'],
      deviceId: json['device_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'device_id': deviceId,
    };
  }
}
