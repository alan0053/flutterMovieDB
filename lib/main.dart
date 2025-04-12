import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/homepage.dart';
import './providers/movieprovider.dart';
import './providers/rentedmovieprovider.dart';
import './theme/theme.dart';

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
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'Movie App',
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
