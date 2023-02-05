// A method that retrieves all the dogs from the dogs table.
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Movie>> loadMovies(Future<Database> database) async {
  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query('movies');

  return List.generate(maps.length, (i) {
    return Movie.fromJson(maps[i]);
  });
}
