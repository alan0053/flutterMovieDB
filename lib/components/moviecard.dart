import 'package:flutter/material.dart';
import '../pages/watchpage.dart';
import '../theme/theme.dart';
import '../data/movie.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../providers/rentedmovieprovider.dart';
import '../pages/rentedpage.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool rented;

  const MovieCard({super.key, required this.movie, required this.rented});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final BorderRadius radius = BorderRadius.vertical(top: Radius.circular(16));
    final rentedProvider = Provider.of<RentedMovieProvider>(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          // with stack i tried to use overlay for the title
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  image: movie.posterPath != null
                      ? DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500/${movie.posterPath}'),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey,
                ),
                child: movie.posterPath == null
                    ? const Center(child: Icon(Icons.movie, size: 100))
                    : null,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Text(
                  movie.title,
                  style: textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // taking only year from the release date
                Text(
                  'Release Date: ${movie.releaseDate?.toString().split('-')[0] ?? 'N/A'}',
                  style: textTheme.bodyLarge,
                ),
                // based on rating i used ternary operator to change the color
                SizedBox(height: 12),
                Text(
                  '♥︎ Popularity: ${movie.popularity.toStringAsFixed(1)}',
                  style: textTheme.bodyLarge?.copyWith(
                    color: movie.popularity <= 5
                        ? colorTheme.ratingLow
                        : movie.popularity <= 10
                            ? colorTheme.ratingMedium
                            : colorTheme.ratingHigh,
                  ),
                ),

                SizedBox(height: 12),
                !rented // if rented instead of price show overview
                    ? Text('Price: \$${movie.priceDollar}.${movie.priceCent}',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorTheme.primary,
                          fontWeight: FontWeight.bold,
                        ))
                    : Text(movie.overview),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: !rented
                        // For Rent
                        ? ElevatedButton.icon(
                            icon: Icon(
                              Icons.paid,
                              color: colorTheme.onSecondary,
                              size: 20,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: const Text("Are you sure ?"),
                                    content: Text(
                                        "Do you really want to rent this movie for \$${movie.priceDollar}.${movie.priceCent} ?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: colorTheme.error,
                                        ),
                                        child: Text(
                                          "Cancel",
                                          style: textTheme.bodyMedium?.copyWith(
                                              color: colorTheme.ratingLow),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // check if the movie is already rented
                                          if (!rentedProvider
                                              .idChecker(movie)) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "I know what you are up to 🙉 .But you can't rent the same movie twice.",
                                                ),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ),
                                            );
                                          } else {
                                            rentedProvider.rentMovie(movie);
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const RentedPage(),
                                              ), //
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                // to prevent overflow for all items
                                                content: Wrap(
                                                  spacing: 8.0,
                                                  runSpacing: 4.0,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.check,
                                                      color:
                                                          colorTheme.ratingHigh,
                                                    ),
                                                    Text(
                                                      movie.title,
                                                      style: textTheme.bodyLarge
                                                          ?.copyWith(
                                                        color: colorTheme
                                                            .ratingLow,
                                                      ),
                                                    ),
                                                    Text(
                                                        " has been rented successfully."),
                                                  ],
                                                ),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          "Confirm",
                                          style: textTheme.bodyMedium?.copyWith(
                                              color: colorTheme.primary),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorTheme.secondary,
                              foregroundColor: colorTheme.onSecondary,
                            ),
                            label: Text('Rent',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorTheme.onSecondary,
                                )),
                            // For watch
                          )
                        : ElevatedButton.icon(
                            icon: Icon(Icons.play_circle_filled,
                                color: colorTheme.onSecondary, size: 20),
                            label: Text('Watch',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorTheme.onSecondary,
                                )),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => WatchPage(movie: movie),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorTheme.secondary,
                              foregroundColor: colorTheme.onSecondary,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
