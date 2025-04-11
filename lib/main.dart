import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/homepage.dart';
import './providers/movieprovider.dart';
import './providers/rentedmovieprovider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => RentedMovieProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // TODO: light / dark theme
      title: 'Movie App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const HomePage(),
    );
  }
}
