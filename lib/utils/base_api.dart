class BaseAPI {
  static String base = "http://192.168.43.244:8000/api";
  var registrationPath = Uri.parse(base + "/register");
  var loginPath = Uri.parse(base + "/login");
  var logoutPath = Uri.parse(base + "/logout");
  var getUserPath = base + "/user/";
  var contributePath = Uri.parse(base + "/contribute");
  var getContributionsPath = base + "/contributions/";
  // more routes
  Map<String,String> headers = {
    "Content-Type": "application/json; charset=UTF-8" };
}