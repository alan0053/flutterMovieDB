import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './rentedpage.dart';
import '../theme/theme.dart';
import '../providers/movieprovider.dart';
import '../components/moviecard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Movie'),
          content: TextField(
            controller: searchController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
          ),
          actions: [
            TextButton(
              onPressed: () {
                final keyword = searchController.text.trim();
                if (keyword.isNotEmpty) {
                  Provider.of<MovieProvider>(context, listen: false)
                      .search(keyword);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Search'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    final movieProvider = Provider.of<MovieProvider>(context);

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
        child: movieProvider.movies.isNotEmpty
            ? ListView.builder(
                itemCount: movieProvider.movies.length,
                itemBuilder: (context, index) {
                  final movie = movieProvider.movies[index];
                  return MovieCard(movie: movie);
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome", style: textTheme.displaySmall),
                    Text("To The Movie App!", style: textTheme.displaySmall),
                    const SizedBox(height: 20),
                    const Text("Use the floating button to search movies"),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dialogBuilder(context);
        },
        backgroundColor: colorTheme.primary,
        foregroundColor: colorTheme.onPrimary,
        child: const Icon(Icons.search),
      ),
    );
  }
}
