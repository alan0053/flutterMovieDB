import 'package:flutter/material.dart';
import '../components/rentedresults.dart';

class RentedPage extends StatelessWidget {
  const RentedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rented Movies"),
      ),
      body: RentedMovieResults(),
    );
  }
}
