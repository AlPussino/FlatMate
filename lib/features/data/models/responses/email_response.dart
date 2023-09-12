class EmailResponse {
  final bool success;
  final String message;
  final String sentTo;

  EmailResponse({
    required this.success,
    required this.message,
    required this.sentTo,
  });

  factory EmailResponse.fromJson(Map<String, dynamic> json) {
    return EmailResponse(
      success: json['success'] as bool,
      sentTo: json['sent_to'] as String,
      message: json['message'] as String,
    );
  }
}
