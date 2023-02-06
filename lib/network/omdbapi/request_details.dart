import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/network/omdbapi/config.dart';
import 'package:movie_mobile/network/omdbapi/omdb_details.dart';

Future<DetailsResponse> requestDetails(Movie movie) async {
  final url = Uri(
      scheme: 'https',
      host: 'www.omdbapi.com',
      path: '',
      query:
          'apikey=$apiKey&t=${movie.name}&y=${movie.year}&type=movie&plot=short&r=json');
  var response = await http.get(url);
  if (response.statusCode != 200) {
    throw Exception("Status ${response.statusCode}");
  }
  String jsonStr = utf8.decode(response.bodyBytes);
  if (jsonStr
      .contains("{\"Response\":\"False\",\"Error\":\"Movie not found!\"}")) {
    throw Exception("Movie not found!");
  }
  return DetailsResponse.fromJson(json.decode(jsonStr));
}
