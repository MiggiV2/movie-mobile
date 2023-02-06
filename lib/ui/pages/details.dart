import 'package:flutter/material.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/ui/widget/omdb_details.dart';
import 'package:movie_mobile/ui/widget/simple_divider.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Movie Details",
            style: TextStyle(fontFamily: "Roboto-Regular", fontSize: 22),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.onBackground,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.name,
                  style:
                      const TextStyle(fontFamily: "Roboto-Bold", fontSize: 20)),
              const SimpleDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Aus dem Jahre ${movie.year}"),
                  Text("Type: ${movie.type}")
                ],
              ),
              Text("Zufinden in ${movie.block}"),
              OmdbDetails(movie: movie),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                        onPressed: () {}, child: Text("Auf Wikipedia öffnen")),
                    OutlinedButton(
                        onPressed: () {}, child: Text("Trailer suchen")),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
