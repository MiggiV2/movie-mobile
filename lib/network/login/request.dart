import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_mobile/network/login/keycloak_token.dart';
import 'package:movie_mobile/network/login/login_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<KeycloakToken> login(String username, password) async {
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
  KeycloakToken login = KeycloakToken.fromJsonMap(json.decode(response.body));
  saveTokens(login);
  return login;
}

Future<void> saveTokens(KeycloakToken login) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('access_token', login.accessToken);
  await prefs.setString('refresh_token', login.refreshToken);
  await prefs.setInt('expires',
      DateTime.now().millisecondsSinceEpoch + login.expiresIn * 1000);
  await prefs.setInt('refresh_expires',
      DateTime.now().millisecondsSinceEpoch + login.refreshExpiresIn * 1000);
}
