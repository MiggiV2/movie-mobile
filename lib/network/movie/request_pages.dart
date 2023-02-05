import 'package:http/http.dart' as http;

Future<int> requestPages() async {
  final url = Uri(
      scheme: 'https',
      host: 'apis.mymiggi.de',
      path: 'movie-archive/public/movie-page-count');
  var response = await http.get(url);
  if (response.statusCode != 200) {
    throw Exception("Status ${response.statusCode}");
  }
  // String jsonStr = utf8.decode(response.bodyBytes);
  return int.parse(response.body);
}
