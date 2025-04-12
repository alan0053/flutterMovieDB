import 'package:flutter/material.dart';
import 'package:flutter_movie_db/pages/watchpage.dart';
import 'package:flutter_movie_db/theme/theme.dart';
import '../data/movie.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../providers/rentedmovieprovider.dart';
import '../pages/rentedpage.dart';

class WatchPage extends StatefulWidget {
  final Movie movie;

  const WatchPage({super.key, required this.movie});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  late final RentedMovieProvider rentedProvider;

  @override
  void initState() {
    super.initState();
    rentedProvider = Provider.of<RentedMovieProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        actions: [
          IconButton(
            icon: Icon(Icons.watch),
            onPressed: () {
              rentedProvider.removeMovieById(widget.movie.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text('Video Here'),
        ),
      ),
    );
  }
}
