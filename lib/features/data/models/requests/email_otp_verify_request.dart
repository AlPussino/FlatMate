class EmailOTPVerifyRequest {
  final String email;
  final String code;

  EmailOTPVerifyRequest({
    required this.email,
    required this.code,
  });

  factory EmailOTPVerifyRequest.fromJson(Map<String, dynamic> json) {
    return EmailOTPVerifyRequest(
      email: json['email'] as String,
      code: json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}
