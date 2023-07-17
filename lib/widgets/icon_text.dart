import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  String? title;
  IconData? icon;
  Color? iconColor;

  IconText(
      {required this.title, required this.icon, this.iconColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor ?? Colors.black,
          size: 15,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Text(
            title ?? "",
            style: const TextStyle(fontSize: 14),
          ),
        )
      ],
    );
  }
}
