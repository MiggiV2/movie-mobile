import 'package:movie_mobile/database/fetch_all.dart';
import 'package:movie_mobile/database/get_movies.dart';
import 'package:movie_mobile/database/insert_movie.dart';
import 'package:movie_mobile/database/open_db.dart';
import 'package:movie_mobile/database/search_movie.dart';
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:sqflite/sqflite.dart';

class MovieDBWrapper {
  static final Future<Database> _database = openMovieDB();

  Future<void> insert(Movie movie) {
    return insertMovie(movie, _database);
  }

  Future<List<Movie>> load() {
    return loadMovies(_database);
  }

  Future<void> synchronize(KeycloakToken token) async {
    return await fetchAllMovies(token, this);
  }

  Future<List<Movie>> search(String query) async {
    return await searchMovie(_database, query);
  }
}
