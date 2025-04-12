import 'package:flutter/material.dart';
import '../components/rentedresults.dart';
// import 'package:provider/provider.dart';
// import '../providers/rentedmovieprovider.dart';

class RentedPage extends StatelessWidget {
  const RentedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final rentedMovieProvider =
    //     Provider.of<RentedMovieProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rented Movies"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RentedMovieResults(),
      ),
    );
  }
}
