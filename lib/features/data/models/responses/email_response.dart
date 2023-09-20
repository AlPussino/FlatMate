class EmailResponse {
  final bool? success;
  final String? message;
  final String? sentTo;

  EmailResponse({
    this.success,
    this.message,
    this.sentTo,
  });

  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      success: json['success'] != null ? json['success'] as bool : null,
      sentTo: json['sent_to'] != null ? json['sent_to'] as String : null,
      message: json['message'] != null ? json['message'] as String : null,
    );
  }
}
