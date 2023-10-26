class AppString {
  AppString._();

  /// Tokens
  static const String tokenKey = 'accessToken';
  static const String refreshTokenKey = 'refreshToken';
  static const String tokenExpiredDate = 'tokenExpiredDate';

  /// Network
  static const String networkError = 'Network Error';

  // UI
  static const String addImageToPost = 'pick at least one photo to post';
  static const String loadingImageToEditPost = 'Loading...';

  // Sign Up helper texts
  static const String fullNameHelperText =
      "Username should be between 3 and 20 characters";
  static const String emailHelperText = "Enter a valid email";
  static const String phoneNumberHelperText = "Enter a valid phone number";
  static const String passwordHelperText = "Password must be at least 8";
  static const String confirmPasswordHelperText = "Confirm the same password";
}
