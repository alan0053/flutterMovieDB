import 'package:flutter/material.dart';

class RentedPage extends StatelessWidget {
  const RentedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rented Movies"),
      ),
      body: const Center(
        child: Text("Rented Movies Page"),
      ),
    );
  }
}
