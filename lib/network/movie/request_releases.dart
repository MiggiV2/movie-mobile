import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_mobile/network/movie/entity/releases.dart';

Future<List<Release>> requestReleases(int limit) async {
  final url = Uri(
      scheme: 'https',
      host: 'gitea.familyhainz.de',
      path: 'api/v1/repos/Miggi/flutter_movie_mobile/releases',
      queryParameters: {'pre-release': 'false', "limit": "$limit"});
  var response = await http.get(url, headers: {
    "Content-Type": "application/json",
  });
  if (response.statusCode != 200) {
    throw Exception("Status ${response.statusCode}");
  }
  String jsonStr = utf8.decode(response.bodyBytes);
  final jsonList = json.decode(jsonStr) as List;
  return jsonList.map((e) => Release.fromJsonMap(e)).toList();
}
