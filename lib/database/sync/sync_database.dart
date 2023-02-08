import 'package:flutter/cupertino.dart';
import 'package:movie_mobile/database/movie_wrapper.dart';
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/network/movie/request_movie.dart';
import 'package:movie_mobile/network/movie/request_sync_list.dart';

Future<void> syncDatabase(MovieDBWrapper db, KeycloakToken token) async {
  requestSyncList(token).then((syncList) {
    syncList.forEach((key, value) async {
      Movie movie = await db.getMovie(key);
      if (movie.id == 0) {
        debugPrint("id:${movie.id} needs to be fetched");
        _update(db, token, movie.id);
      } else {
        compareHash(movie, value, db, token);
      }
    });
  });
}

void compareHash(Movie movie, value, MovieDBWrapper db, KeycloakToken token) {
  String hash = movie.getHash().toUpperCase();
  bool needFetch = hash.toUpperCase() != value;
  if (needFetch) {
    debugPrint("id:${movie.id} needs to be fetched");
    _update(db, token, movie.id);
  }
}

Future<void> _update(MovieDBWrapper db, KeycloakToken token, int id) async {
  Movie movie = await requestMovie(token, id);
  db.insert(movie);
}
