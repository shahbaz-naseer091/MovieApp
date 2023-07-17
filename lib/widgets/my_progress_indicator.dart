import 'package:flutter/material.dart';

class MyProgressIndicator extends StatefulWidget {
  const MyProgressIndicator({super.key});

  @override
  _MyProgressIndicatorState createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulating a delay to simulate an async operation
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const LinearProgressIndicator();
    return const Visibility(
      visible: false,
      child: LinearProgressIndicator(),
    );
  }
}
