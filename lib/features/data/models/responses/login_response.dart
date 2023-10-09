class LoginResponse {
  final String token;
  final String? type;
  final DateTime? expiration;
  final String? refreshToken;

  LoginResponse({
    required this.token,
    this.type,
    this.expiration,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      type: json['type'] != null ? json['type'] : null,
      expiration: json['expiration'] != null
          ? DateTime.parse(json['expiration'])
          : null,
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'type': type!,
      'expiration': expiration!.toIso8601String(),
      'refresh_token': refreshToken,
    };
  }
}
