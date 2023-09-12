class LoginResponse {
  final String token;
  final String type;
  final DateTime expiration;
  final String refreshToken;

  LoginResponse({
    required this.token,
    required this.type,
    required this.expiration,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      type: json['type'],
      expiration: DateTime.parse(json['expiration']),
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'type': type,
      'expiration': expiration.toIso8601String(),
      'refresh_token': refreshToken,
    };
  }
}
