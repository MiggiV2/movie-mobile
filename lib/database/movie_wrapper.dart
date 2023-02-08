import 'package:movie_mobile/database/fetch_all.dart';
import 'package:movie_mobile/database/queries/get_movie.dart';
import 'package:movie_mobile/database/queries/get_movies.dart';
import 'package:movie_mobile/database/queries/insert_movie.dart';
import 'package:movie_mobile/database/queries/open_db.dart';
import 'package:movie_mobile/database/queries/search_movie.dart';
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

  Future<Movie> getMovie(String id) async {
    return await getMovieByID(_database, id);
  }
}
