import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:movieviewer/API/api_service.dart';
import 'package:movieviewer/models/movie_detail_model.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String title, poster_path;
  // final String overview;
  // final List<String> genres;
  // final double vote_average;
  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.poster_path,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService().getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        shadowColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 5,
        toolbarHeight: 60.0,
        title: Text(
          'Back to list',
          style: const TextStyle(
            fontSize: 23,
          ),
        ),
      ),
      body: FutureBuilder(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 10.0,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${widget.poster_path}'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // for (var genre in snapshot.data!.genres) Text(genre),
                      Text(
                        '${snapshot.data!.vote_average}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    snapshot.data!.overview,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
