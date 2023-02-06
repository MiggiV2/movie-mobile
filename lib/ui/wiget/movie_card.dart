import 'package:flutter/material.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Text(
          movie.name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.background, fontSize: 19),
        ),
      ),
    );
  }
}
