import 'package:movie_mobile/database/movie_wrapper.dart';
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/network/auth/refresh.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/network/movie/request_movies.dart';
import 'package:movie_mobile/network/movie/request_pages.dart';

Future<void> fetchAllMovies(KeycloakToken token, MovieDBWrapper db) async {
  if (token.expiresIn < DateTime.now().millisecondsSinceEpoch) {
    token = await refresh(token);
  }

  int count = await requestPages();
  for (int i = 0; i <= count; i++) {
    await _loadPage(token, i, db);
  }
}

Future<void> _loadPage(KeycloakToken token, int i, MovieDBWrapper db) async {
  List<Movie> movies = await requestMovies(token, i);

  for (var m in movies) {
    db.insert(m);
  }
}
