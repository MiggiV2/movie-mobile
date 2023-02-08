import 'package:flutter/material.dart';
import 'package:movie_mobile/database/movie_wrapper.dart';
import 'package:movie_mobile/database/sync/sync_database.dart';
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/ui/widget/movie_card.dart';

class Home extends StatefulWidget {
  final KeycloakToken token;

  const Home({Key? key, required this.token}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final MovieDBWrapper _db = MovieDBWrapper();
  late Future<List<Movie>> movies = _db.load();
  bool _isLoading = false;

  @override
  void initState() {
    //updateMovieList(forceUpdate: true);
    syncDatabase(_db, widget.token);
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
        if (snapshot.hasData && !_isLoading) {
          return buildMovies(snapshot, context);
        } else {
          return const Padding(
            padding: EdgeInsets.only(top: 48.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget buildMovies(
      AsyncSnapshot<List<Movie>> snapshot, BuildContext context) {
    if (snapshot.data!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text("No movies found!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                  fontFamily: "Roboto-Regular")),
        ),
      );
    }
    return Expanded(
        child: ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) => MovieCard(movie: snapshot.data![index]),
    ));
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
    _isLoading = true;
    _db.search(query).then((result) {
      setState(() {
        movies = Future<List<Movie>>.value(result);
        _isLoading = false;
      });
    }).onError((error, stackTrace) => handleError(error));
  }

  void updateMovieList({bool forceUpdate = false}) {
    movies.then((value) {
      if (forceUpdate || value.isEmpty) {
        _isLoading = value.isEmpty; // only loading when no movies
        _db.synchronize(widget.token).then((value) {
          debugPrint("Finished. Update to date now!");
          setState(() {
            movies = _db.load();
            _isLoading = false;
          });
        }).onError((error, stackTrace) => handleError(error));
      }
    });
  }

  handleError(e) {
    setState(() {
      _isLoading = false;
    });
    debugPrint(e.toString());
    String msg = "Error";
    if (e.toString().startsWith("Failed host lookup: ")) {
      msg = "You are offline";
    } else {
      msg = e.toString().replaceFirst("Exception: ", "");
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
