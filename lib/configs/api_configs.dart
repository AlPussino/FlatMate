class ApiConfigs {
  //base url
  static const String baseUrl = "http://192.168.0.108:8080";

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
  static const String aboutOtherUserUrl = "$baseUrl/api/user/";
  static const String searchUserUrl = "$baseUrl/api/user/search?k=";

  //post urls
  static const String createPostUrl = "$baseUrl/api/post";
  static const String getMyPostsUrl = "$baseUrl/api/post/me";
  static const String getPostDetailUrl = "$baseUrl/api/post/";
  static const String deleteMyPostUrl = "$baseUrl/api/post/";
  static const String getAllPostsUrl = "$baseUrl/api/post?cursor=";
  static const String savePostUrl = "$baseUrl/api/post/";
  static const String getSavedPostsUrl = "$baseUrl/api/post/me/save";
}

///

//base url
const baseUrl = ApiConfigs.baseUrl;

//logIn urls
const logInUrl = ApiConfigs.logInUrl;

//signUp urls
const signUpUrl = ApiConfigs.signUpUrl;
const emailOTPVerifyUrl = ApiConfigs.emailOTPVerifyUrl;

//auth urls
const refreshTokenUrl = ApiConfigs.refreshTokenUrl;
const forgetPasswordUrl = ApiConfigs.forgetPasswordUrl;
const forgetPasswordOTPVerifyUrl = ApiConfigs.forgetPasswordOTPVerifyUrl;
const resetPasswordUrl = ApiConfigs.resetPasswordUrl;

//user urls
const aboutMeUrl = ApiConfigs.aboutMeUrl;
const changeUserNameUrl = ApiConfigs.changeUserNameUrl;
const changePasswordUrl = ApiConfigs.changePasswordUrl;
const changeMobileNumberUrl = ApiConfigs.changeMobileNumberUrl;
const uploadProfileUrl = ApiConfigs.uploadProfileUrl;
const addSocialContactUrl = ApiConfigs.addSocialContactUrl;
const removeSocialContactUrl = ApiConfigs.removeSocialContactUrl;
const aboutOtherUserUrl = ApiConfigs.aboutOtherUserUrl;
const searchUserUrl = ApiConfigs.searchUserUrl;

//post urls
const createPostUrl = ApiConfigs.createPostUrl;
const getMyPostsUrl = ApiConfigs.getMyPostsUrl;
const getPostDetailUrl = ApiConfigs.getPostDetailUrl;
const deleteMyPostUrl = ApiConfigs.deleteMyPostUrl;
const getAllPostsUrl = ApiConfigs.getAllPostsUrl;
const savePostUrl = ApiConfigs.savePostUrl;
const getSavedPostsUrl = ApiConfigs.getSavedPostsUrl;
