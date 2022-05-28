import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiHandler {
  final storage = FlutterSecureStorage();
  String baseurl = "http://10.0.2.2:4000";
  var log = Logger();

  Future get(String url) async {
    String? token = await storage.read(key: "token");
    url = formater(url);
    // /user/register
    var response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    log.d(body);
    url = formater(url);
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }
}
