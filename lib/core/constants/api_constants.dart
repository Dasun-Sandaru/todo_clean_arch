class ApiConstants {
  // base URL for the API
  static const String baseUrl = "http://192.168.1.8:3000/api/v1";

  // todo endpoints
  static const String todoPath = "$baseUrl/todo";
  static String todoById(String id) => "$baseUrl/todo/$id";

  static const String refreshTokenEndpoint = "$baseUrl/auth/refresh-token";

  // timeouts (in milliseconds)
  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;
}
