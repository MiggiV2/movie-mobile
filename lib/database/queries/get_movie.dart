import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:sqflite/sqflite.dart';

Future<Movie> getMovieByID(Future<Database> database, String id) async {
  final db = await database;

  final List<Map<String, dynamic>> maps =
      await db.query('movies', where: 'ID = ?', whereArgs: [id]);

  if (maps.isEmpty) {
    return Future.value(Movie(0, 0, "", "", "", "", ""));
  }
  return Future.value(Movie.fromJson(maps[0]));
}
