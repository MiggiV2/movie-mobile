import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/network/movie/request_movies.dart';

Future<Map<String, dynamic>> requestSyncList(KeycloakToken token) async {
  if (token.expiresIn < DateTime.now().millisecondsSinceEpoch) {
    await updateToken(token);
  }
  final url = Uri(
      scheme: 'https',
      host: 'apis.mymiggi.de',
      path: 'movie-archive/user/sync');
  var response = await http.get(url, headers: {
    "Content-Type": "application/json",
    "authorization": "Bearer ${token.accessToken}"
  });
  if (response.statusCode != 200) {
    throw Exception("Status ${response.statusCode}");
  }
  String jsonStr = utf8.decode(response.bodyBytes);
  final Map<String, dynamic> syncList = json.decode(jsonStr);
  return syncList;
}
