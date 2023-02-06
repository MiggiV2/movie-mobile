import 'package:flutter/material.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/ui/pages/details.dart';
import 'package:movie_mobile/ui/widget/simple_divider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openDetailsPage(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 20,
                    fontFamily: "Roboto-Bold"),
              ),
              const SimpleDivider(),
              Text("Aus dem Jahre ${movie.year}",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 14))
            ],
          ),
        ),
      ),
    );
  }

  void openDetailsPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetails(movie: movie),
        ));
  }
}
