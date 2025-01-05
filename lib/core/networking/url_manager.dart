class UrlManager {
  // Base url
  static const _baseUrl = "https://ezycourse.com/api/app";
  static const _baseUrl2 = "https://iap.ezycourse.com/api/app";

  static String loginUrl = "$_baseUrl/student/auth/login";
  static String feedUrl = "$_baseUrl2/teacher/community/getFeed?status=feed";
  static String logoutUrl = "$_baseUrl2/student/auth/logout";
  static String createLikeUrl = "$_baseUrl2/teacher/community/createLike";
}
