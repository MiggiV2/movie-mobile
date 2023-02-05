import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertMovie(Movie movie, Future<Database> database) async {
  final db = await database;

  await db.insert(
    'movies',
    movie.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
