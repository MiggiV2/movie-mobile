import 'package:flutter/material.dart';
import 'package:movie_mobile/database/movie_wrapper.dart';
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/ui/wiget/movie_card.dart';

class Home extends StatefulWidget {
  final KeycloakToken token;

  const Home({Key? key, required this.token}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final MovieDBWrapper _db = MovieDBWrapper();
  late Future<List<Movie>> movies = _db.load();

  @override
  void initState() {
    fetchAllOnEmpty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Movie Archive",
            style: TextStyle(fontFamily: "Roboto-Bold", fontSize: 24),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Column(
        children: [_buildSearch(), buildMovieList()],
      ),
    );
  }

  FutureBuilder buildMovieList() {
    return FutureBuilder<List<Movie>>(
      future: movies,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Expanded(
              child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) =>
                MovieCard(movie: snapshot.data![index]),
          ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Padding _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18, left: 18, right: 18),
      child: TextField(
          onChanged: updateList,
          decoration: const InputDecoration(
            hintText: "Movie title",
            suffixIcon: Icon(Icons.search),
          )),
    );
  }

  void updateList(query) {
    _db.search(query).then((result) {
      setState(() {
        movies = Future<List<Movie>>.value(result);
      });
    });
  }

  void fetchAllOnEmpty() {
    movies.then((value) {
      if (value.isEmpty) {
        _db.synchronize(widget.token).then((value) {
          debugPrint("Finished. Update to date now!");
          setState(() {
            movies = _db.load();
          });
        });
      }
    });
  }
}
