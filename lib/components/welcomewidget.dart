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
          Text("Welcome", style: textTheme.displayLarge),
          const SizedBox(height: 32),
          Text("To Berk's Movie App!", style: textTheme.displayMedium),
          const SizedBox(height: 20),
          Text(
            "Use the floating button to search movies",
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
