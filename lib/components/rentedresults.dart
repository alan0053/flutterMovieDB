import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rentedmovieprovider.dart';
import '../components/moviecard.dart';

class RentedMovieResults extends StatelessWidget {
  const RentedMovieResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RentedMovieProvider>(
      builder: (context, provider, child) {
        final movies = provider.rentedMovies;
        if (movies.isEmpty) {
          return Center(
            child: Text("No rented movies available."),
          );
        }
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index], rented: true);
          },
        );
      },
    );
  }
}
