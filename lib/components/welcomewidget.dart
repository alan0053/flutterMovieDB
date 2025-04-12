import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome", style: textTheme.displaySmall),
          Text("To Berk's Movie App!", style: textTheme.displaySmall),
          const SizedBox(height: 20),
          const Text("Use the floating button to search movies"),
        ],
      ),
    );
  }
}
