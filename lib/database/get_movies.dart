// A method that retrieves all the dogs from the dogs table.
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Movie>> loadMovies(Future<Database> database) async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('movies');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Movie.fromJson(maps[i]);
  });
}
