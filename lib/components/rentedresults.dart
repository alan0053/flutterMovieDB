import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/movie.dart';
import '../components/moviecard.dart';
import '../providers/rentedmovieprovider.dart';

class RentedMovieResults extends StatelessWidget {
  const RentedMovieResults({super.key});

  // decided to use future builder so im converting the rented movies to a future
  Future<List<Movie>> _getRentedMovies(BuildContext context) async {
    final rentedProvider =
        Provider.of<RentedMovieProvider>(context, listen: false);
    return Future.value(rentedProvider.rentedMovies);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder<List<Movie>>(
      future: _getRentedMovies(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // The future (promise) is still pending.
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Something went wrong.
          return Center(
            child: Text(
              "Something went wrong. Please try again. Error: ${snapshot.error}",
              style: textTheme.bodyLarge,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "No rented movies :(",
              style: textTheme.bodyLarge,
            ),
          );
        } else {
          final movies = snapshot.data!;
          // Return ListView with movie cards.
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies[index], rented: true);
            },
          );
        }
      },
    );
  }
}
