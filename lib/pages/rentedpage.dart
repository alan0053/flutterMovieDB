import 'package:flutter/material.dart';
import '../components/rentedresults.dart';
import 'package:provider/provider.dart';
import '../providers/rentedmovieprovider.dart';

class RentedPage extends StatelessWidget {
  const RentedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final rentedMovieProvider =
        Provider.of<RentedMovieProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rented Movies"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: colorTheme.error),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Clear All Rented Movies"),
                    content: Text(
                        "Are you sure you want to clear all rented movies? There is no coming back from this."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: colorTheme.primary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          rentedMovieProvider.clearRentedMovies();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Clear",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: colorTheme.error),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RentedMovieResults(),
      ),
    );
  }
}
