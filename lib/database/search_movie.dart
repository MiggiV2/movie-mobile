import 'package:flutter/cupertino.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:sqflite/sqflite.dart';

Future<List<Movie>> searchMovie(Future<Database> database, String query) async {
  int start = DateTime.now().millisecondsSinceEpoch;
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('movies');
  List<Movie> bestHits = [];
  List<Movie> normalHits = [];
  List<Movie> justHits = [];

  query = query.toLowerCase();

  for (var value in maps) {
    Movie movie = Movie.fromJson(value);
    String name = movie.name.toLowerCase();
    if (name == query) {
      bestHits.add(movie);
    } else if (name.startsWith(query)) {
      normalHits.add(movie);
    } else if (name.contains(query)) {
      justHits.add(movie);
    }
  }

  bestHits.addAll(normalHits);
  bestHits.addAll(justHits);
  debugPrint("Search took ${DateTime.now().millisecondsSinceEpoch - start}ms");
  return bestHits;
}
