import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';

import 'entity/movie.dart';

Future<List<Movie>> loadMovies(KeycloakToken token, int page) async {
  final url = Uri(
      scheme: 'https',
      host: 'apis.mymiggi.de',
      path: 'movie-archive/user/get-movies',
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
