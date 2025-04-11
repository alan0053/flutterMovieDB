import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './rentedpage.dart';
import '../theme/theme.dart';
import '../providers/movieprovider.dart';
import '../components/moviecard.dart';
import '../data/movie.dart';
import '../components/search_dialog.dart';
import '../components/welcomewidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Movie>>? _moviesFuture; // Future for movie search results
  var keywordState = "";

  @override
  void initState() {
    super.initState();
    // Initially, no search has been performed.
    _moviesFuture = null;
  }

  @override
  Widget build(BuildContext context) {
    // Get theme values
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RentedPage()),
                  );
                },
              ),
              Positioned(
                right: 4,
                top: 4,
                child: CircleAvatar(
                  backgroundColor: colorTheme.error,
                  radius: 9,
                  child: Text(
                    '6',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorTheme.onPrimary,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _moviesFuture != null
            ? FutureBuilder<List<Movie>>(
                future: _moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // The future (promise) is still pending.
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
              )
            : WelcomeWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => SearchDialog(
              parentContext: context,
              onSearch: (future, keyword) {
                // update the movie future and keyword with callback
                setState(() {
                  _moviesFuture = future;
                  keywordState = keyword;
                });
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                future.then((movies) {
                  if (!mounted) return;
                  if (movies.isEmpty) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text("No movies found named $keyword."),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                }).catchError((error) {
                  if (!mounted) return;
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text("Something went wrong. Error: $error"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                });
              },
            ),
          );
        },
        backgroundColor: colorTheme.primary,
        foregroundColor: colorTheme.onPrimary,
        child: const Icon(Icons.search),
      ),
    );
  }
}
