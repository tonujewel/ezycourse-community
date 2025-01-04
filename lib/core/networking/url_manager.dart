class UrlManager {
  // Base url
  static const _baseUrl = "https://ezycourse.com/api/app";

  static String loginUrl = "$_baseUrl/student/auth/login";
  static String feedUrl = "$_baseUrl/teacher/community/getFeed?status=feed";
}
