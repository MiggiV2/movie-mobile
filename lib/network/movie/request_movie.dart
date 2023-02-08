import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/network/auth/refresh.dart';

import 'entity/movie.dart';

Future<Movie> requestMovie(KeycloakToken token, int id) async {
  if (token.expiresIn < DateTime.now().millisecondsSinceEpoch) {
    await updateToken(token);
  }
  final url = Uri(
      scheme: 'https',
      host: 'apis.mymiggi.de',
      path: 'movie-archive/user/get-movie-by-id',
      query: 'id=$id');
  var response = await http.get(url, headers: {
    "Content-Type": "application/json",
    "authorization": "Bearer ${token.accessToken}"
  });
  if (response.statusCode != 200) {
    throw Exception("Status ${response.statusCode}");
  }
  String jsonStr = utf8.decode(response.bodyBytes);
  return Movie.fromJson(json.decode(jsonStr));
}

Future<void> updateToken(KeycloakToken token) async {
  debugPrint("Refreshing token!");
  KeycloakToken newToken = await refresh(token);
  token.accessToken = newToken.accessToken;
  token.refreshExpiresIn = newToken.refreshExpiresIn;
  token.refreshToken = newToken.refreshToken;
  token.expiresIn = newToken.expiresIn;
  token.idToken = newToken.idToken;
  token.scope = newToken.scope;
  token.tokenType = newToken.tokenType;
  debugPrint("Refresh done.");
}
