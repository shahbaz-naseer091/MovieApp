import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Here is your favorite movies list",
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
