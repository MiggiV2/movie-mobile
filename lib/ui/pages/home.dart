import 'package:flutter/material.dart';
import 'package:movie_mobile/database/movie_wrapper.dart';
import 'package:movie_mobile/network/auth/entity/keycloak_token.dart';
import 'package:movie_mobile/network/auth/refresh.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/network/movie/load_movies.dart';

class Home extends StatefulWidget {
  final KeycloakToken token;

  const Home({Key? key, required this.token}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Movie>> movies = Future<List<Movie>>.value([]);

  @override
  void initState() {
    if (widget.token.expiresIn < DateTime.now().millisecondsSinceEpoch) {
      debugPrint("Need refresh! ${widget.token.refreshToken}");
      updateToken();
    } else {
      movies = loadMovies(widget.token, 0);
    }
    testMovie();
    super.initState();
  }

  void updateToken() {
    refresh(widget.token).then(
      (newToken) {
        widget.token.accessToken = newToken.accessToken;
        widget.token.refreshExpiresIn = newToken.refreshExpiresIn;
        widget.token.refreshToken = newToken.refreshToken;
        widget.token.expiresIn = newToken.expiresIn;
        widget.token.idToken = newToken.idToken;
        widget.token.scope = newToken.scope;
        widget.token.tokenType = newToken.tokenType;
        debugPrint("Done!");

        setState(() {
          movies = loadMovies(widget.token, 0);
        });
      },
    );
  }

  void testMovie() {
    MovieDBWrapper db = MovieDBWrapper();
    db.load().then(
      (dbList) {
        for (var movie in dbList) {
          debugPrint("Movie ${movie.name}");
        }
      },
    );
    movies.then(
      (value) {
        for (var movie in value) {
          db.insert(movie);
        }
      },
    );
    db.load().then(
      (dbList) {
        for (var movie in dbList) {
          debugPrint("Movie ${movie.name}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Movie Archive",
          style: TextStyle(fontFamily: "Roboto-Bold", fontSize: 21),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
        if (snapshot.hasData) {
          return Expanded(
              child: ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) =>
                buildMovieRow(snapshot.data![index]),
          ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildMovieRow(Movie movie) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          movie.name,
          style: TextStyle(
              color: Theme.of(context).colorScheme.background, fontSize: 19),
        ),
      ),
    );
  }

  Padding _buildSearch() {
    return const Padding(
      padding: EdgeInsets.all(18.0),
      child: TextField(
          decoration: InputDecoration(
        hintText: "Movie title",
        suffixIcon: Icon(Icons.search),
      )),
    );
  }
}
