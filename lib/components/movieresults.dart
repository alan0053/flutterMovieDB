import 'package:flutter/material.dart';
import 'package:flutter_movie_db/components/welcomewidget.dart';
import '../data/movie.dart';
import './moviecard.dart';

class MovieResultsWidget extends StatelessWidget {
  final Future<List<Movie>>? moviesFuture;

  const MovieResultsWidget({
    super.key,
    required this.moviesFuture,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<List<Movie>>(
      future: moviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // The future is still pending.
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something went wrong. Please try again. Error: ${snapshot.error}",
              style: textTheme.bodyLarge,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return WelcomeWidget();
        } else {
          final movies = snapshot.data!;
          // Return ListView with movie cards.
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies[index]);
            },
          );
        }
      },
    );
  }
}
