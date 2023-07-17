import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularIconButton extends StatelessWidget {
  IconData? icon;
  double? width;
  double? height;
  VoidCallback onPress;

  CircularIconButton(
      {required this.icon,
      this.width,
      this.height,
      required this.onPress,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? 28,
        height: height ?? 28,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Center(
          child: IconButton(
            icon: Icon(icon, size: 12.0),
            color: Colors.black,
            onPressed: onPress,
          ),
        ));
  }
}
