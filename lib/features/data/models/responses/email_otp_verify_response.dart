class EmailOTPVerifyResponse {
  final bool success;
  final String? message;

  EmailOTPVerifyResponse({
    required this.success,
    this.message,
  });

  factory EmailOTPVerifyResponse.fromJson(Map<String, dynamic> json) {
    return EmailOTPVerifyResponse(
      success: json['success'] as bool,
      message: json['message'] != null ? json['message'] as String : null,
    );
  }
}
