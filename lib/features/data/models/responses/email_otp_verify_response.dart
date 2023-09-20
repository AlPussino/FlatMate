class EmailOTPVerifyResponse {
  final bool success;
  final String? message;
  final String? token;

  EmailOTPVerifyResponse({
    required this.success,
    this.message,
    this.token,
  });

  factory EmailOTPVerifyResponse.fromJson(Map<String, dynamic> json) {
    return EmailOTPVerifyResponse(
      success: json['success'] as bool,
      message: json['message'] != null ? json['message'] as String? : null,
      token: json['token'] != null ? json['token'] as String? : null,
    );
  }
}
