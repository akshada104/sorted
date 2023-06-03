import 'http_client.dart';

class LoginController {
  LoginController._privateConstructor();

  static final LoginController _instance =
      LoginController._privateConstructor();

  factory LoginController() {
    return _instance;
  }

  final HttpClient _httpClient = HttpClient();

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    var response = await _httpClient.post(
      serverUrl: 'https://dummyjson.com/auth/login',
      body: {"username": email, "password": password},
    );
    print('resss $response');
    return response;
  }
}
