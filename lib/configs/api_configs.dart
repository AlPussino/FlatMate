class ApiConfigs {
  //base url
  static const String baseUrl = "http://192.168.0.104:8080";

  //logIn urls
  static const String logInUrl = "$baseUrl/api/auth/login";

  //signUp urls
  static const String signUpUrl = "$baseUrl/api/auth/user/register";
  static const String emailOTPVerifyUrl = "$baseUrl/api/auth/user/verify";

  //auth urls
  static const String refreshTokenUrl =
      "$baseUrl/api/auth/refresh-token?token=";
  static const String forgetPasswordUrl = "$baseUrl/api/user/check-email";
  static const String forgetPasswordOTPVerifyUrl =
      "$baseUrl/api/user/verify-otp";
  static const String resetPasswordUrl = "$baseUrl/api/user/reset-password";

  //user urls
  static const String aboutMeUrl = "$baseUrl/api/user/me";
  static const String changeUserNameUrl = "$baseUrl/api/user/me/username";
  static const String changePasswordUrl = "$baseUrl/api/user/me/password";
  static const String changeMobileNumberUrl =
      "$baseUrl/api/user/me/mobile-number";
  static const String uploadProfileUrl = "$baseUrl/api/user/me/profile";
  static const String addSocialContactUrl =
      "$baseUrl/api/user/me/social-contact";
  static const String removeSocialContactUrl =
      "$baseUrl/api/user/me/social-contact/";

  //post urls
  static const String createPostUrl = "$baseUrl/api/post";
  static const String getMyPostsUrl = "$baseUrl/api/post/me";
  static const String getPostDetailUrl = "$baseUrl/api/post/";
  static const String deleteMyPostUrl = "$baseUrl/api/post/";
}

///

//base url
const baseUrl = ApiConfigs.baseUrl;

//logIn urls
const kLogInUrl = ApiConfigs.logInUrl;

//signUp urls
const kSignUpUrl = ApiConfigs.signUpUrl;
const kEmailOTPVerifyUrl = ApiConfigs.emailOTPVerifyUrl;

//auth urls
const kRefreshTokenUrl = ApiConfigs.refreshTokenUrl;
const kForgetPasswordUrl = ApiConfigs.forgetPasswordUrl;
const kForgetPasswordOTPVerifyUrl = ApiConfigs.forgetPasswordOTPVerifyUrl;
const kResetPasswordUrl = ApiConfigs.resetPasswordUrl;

//user urls
const kAboutMeUrl = ApiConfigs.aboutMeUrl;
const kChangeUserNameUrl = ApiConfigs.changeUserNameUrl;
const kChangePasswordUrl = ApiConfigs.changePasswordUrl;
const kChangeMobileNumberUrl = ApiConfigs.changeMobileNumberUrl;
const kUploadProfileUrl = ApiConfigs.uploadProfileUrl;
const kAddSocialContactUrl = ApiConfigs.addSocialContactUrl;
const kRemoveSocialContactUrl = ApiConfigs.removeSocialContactUrl;

//post urls
const kCreatePostUrl = ApiConfigs.createPostUrl;
const kGetMyPostsUrl = ApiConfigs.getMyPostsUrl;
const kGetPostDetailUrl = ApiConfigs.getPostDetailUrl;
const kDeleteMyPostUrl = ApiConfigs.deleteMyPostUrl;
