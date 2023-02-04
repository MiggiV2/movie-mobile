import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_mobile/network/login/login_exception.dart';
import 'package:movie_mobile/ui/pages/login_response.dart';

Future<LoginResponse> login(String username, password) async {
  var url = Uri.https('apis.mymiggi.de', 'movie-archive/auth/login');
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: "{\"username\":\"$username\",\"password\":\"$password\"}");

  if (response.statusCode == 401) {
    throw IncorrectException();
  }
  if (response.statusCode != 200) {
    throw Exception("Unexpected status code ${response.statusCode}");
  }
  LoginResponse login = LoginResponse.fromJsonMap(json.decode(response.body));
  return login;
}
