class ApiPConfigs {
  //base url
  static const String baseUrl = "http://192.168.0.115:8080";

  //logIn urls
  static const String logInUrl = "$baseUrl/api/auth/login";

  //signUp urls
  static const String signUpUrl = "$baseUrl/api/auth/user/register";
  static const String emailOTPVerifyUrl = "$baseUrl/api/auth/user/verify";

  //user urls
  static const String aboutMeUrl = "$baseUrl/api/user/me";
  static const String refreshTokenUrl =
      "$baseUrl/api/auth/refresh-token?token=";
}

///

//base url
const baseUrl = ApiPConfigs.baseUrl;

//logIn urls
const kLogInUrl = ApiPConfigs.logInUrl;

//signUp urls
const kSignUpUrl = ApiPConfigs.signUpUrl;
const kEmailOTPVerifyUrl = ApiPConfigs.emailOTPVerifyUrl;

//user urls
const kAboutMeUrl = ApiPConfigs.aboutMeUrl;
const kRefreshTokenUrl = ApiPConfigs.refreshTokenUrl;
