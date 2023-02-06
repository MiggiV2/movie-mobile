import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';

import '../auth/refresh.dart';
import 'entity/movie.dart';

Future<List<Movie>> requestMovies(KeycloakToken token, int page) async {
  if (token.expiresIn < DateTime.now().millisecondsSinceEpoch) {
    await _refresh(token);
  }
  final url = Uri(
      scheme: 'https',
      host: 'apis.mymiggi.de',
      path: 'movie-archive/user/sorted-movies/by-name',
      query: 'page=$page');
  var response = await http.get(url, headers: {
    "Content-Type": "application/json",
    "authorization": "Bearer ${token.accessToken}"
  });
  if (response.statusCode != 200) {
    throw Exception("Status ${response.statusCode}");
  }
  String jsonStr = utf8.decode(response.bodyBytes);
  final jsonList = json.decode(jsonStr) as List;
  return jsonList.map((e) => Movie.fromJson(e)).toList();
}

Future<void> _refresh(KeycloakToken token) async {
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
