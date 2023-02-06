import 'package:flutter/material.dart';
import 'package:movie_mobile/network/movie/entity/movie.dart';
import 'package:movie_mobile/network/omdbapi/omdb_details.dart';
import 'package:movie_mobile/network/omdbapi/request_details.dart';

class OmdbDetails extends StatefulWidget {
  final Movie movie;

  const OmdbDetails({Key? key, required this.movie}) : super(key: key);

  @override
  State<OmdbDetails> createState() => _OmdbDetailsState();
}

class _OmdbDetailsState extends State<OmdbDetails> {
  late Future<DetailsResponse> details =
      requestDetails(widget.movie).onError((error, stackTrace) {
    debugPrint(error.toString());
    return DetailsResponse("", "", "", "", "", "", "", "", "", "", "", "", "",
        "", [], "", "", "", "", "", "", "", "", "", "");
  });

  @override
  void initState() {
    super.initState();
    requestDetails(widget.movie).then((value) {
      details = Future.value(value);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailsResponse>(
      future: details,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.Poster.isEmpty) {
            return Container();
          }
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(snapshot.data!.Poster))),
              ),
              Text("Dauer ${snapshot.data!.Runtime}"),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
