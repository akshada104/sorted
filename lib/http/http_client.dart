import 'dart:convert';

import 'package:http/http.dart' as http;

// Singleton class to ensure only once http client is working on the application

class HttpClient {
  HttpClient._privateConstructor();

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  Future<Map<String, dynamic>> get({
    required String serverUrl,
  }) async {
    var url = Uri.parse(serverUrl);
    var response = await http.get(
      url,
      headers: await _getHeaders(),
    );

    return {
      'statusCode': response.statusCode,
      'body': response.body,
    };
  }

  Future<Map<String, dynamic>> post({
    required String serverUrl,
    required dynamic body,
  }) async {
    var url = Uri.parse(serverUrl);
    var response = await http.post(
      url,
      body: jsonEncode(body),
      headers: await _getHeaders(),
    );
    return {
      'statusCode': response.statusCode,
      'body': response.body,
    };
  }

  Future<Map<String, String>> _getHeaders() async {
    return {
      'Content-type': 'application/json',
    };
  }
}
