class ApiConfigs {
  //base url
  static const String baseUrl = "http://192.168.0.117:8080";

  //logIn urls
  static const String logInUrl = "$baseUrl/api/auth/login";

  //signUp urls
  static const String signUpUrl = "$baseUrl/api/auth/users/register";
  static const String emailOTPVerifyUrl = "$baseUrl/api/auth/users/verify";

  //auth urls
  static const String refreshTokenUrl =
      "$baseUrl/api/auth/refresh-token?token=";
  static const String forgetPasswordUrl = "$baseUrl/api/users/email";
  static const String forgetPasswordOTPVerifyUrl = "$baseUrl/api/users/verify";
  static const String resetPasswordUrl = "$baseUrl/api/users/password";

  //user urls
  static const String aboutMeUrl = "$baseUrl/api/users/me";
  static const String changeUserNameUrl = "$baseUrl/api/users/me/username";
  static const String changePasswordUrl = "$baseUrl/api/users/me/password";
  static const String changeMobileNumberUrl =
      "$baseUrl/api/users/me/mobile-number";
  static const String uploadProfileUrl = "$baseUrl/api/users/me/profile";
  static const String addSocialContactUrl =
      "$baseUrl/api/users/me/social-contact";
  static const String removeSocialContactUrl =
      "$baseUrl/api/users/me/social-contact/";
  static const String aboutOtherUserUrl = "$baseUrl/api/users/";
  static const String searchUserUrl = "$baseUrl/api/users/search?k=";

  //post urls
  static const String createPostUrl = "$baseUrl/api/posts";
  static const String getMyPostsUrl = "$baseUrl/api/posts/me";
  static const String getPostDetailUrl = "$baseUrl/api/posts/";
  static const String deleteMyPostUrl = "$baseUrl/api/posts/";
  static const String getAllPostsUrl = "$baseUrl/api/posts";
  static const String savePostUrl = "$baseUrl/api/posts/";
  static const String getSavedPostsUrl = "$baseUrl/api/posts/me/save";
  static const String editTenantsUrl = "$baseUrl/api/posts/me/";
  static const String editPostUrl = "$baseUrl/api/posts/";
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
const editTenantsUrl = ApiConfigs.editTenantsUrl;
const editPostUrl = ApiConfigs.editPostUrl;
