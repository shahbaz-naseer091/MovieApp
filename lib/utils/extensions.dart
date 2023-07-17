import 'package:flutter/material.dart';

extension ViewExtensions on BuildContext {
  void pushToNextScreen(Widget screen) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void pushAndReplace(Widget screen) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void pushAndClearStack(Widget screen) {
    Navigator.pushAndRemoveUntil(this,
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  Future<dynamic> push(Widget screen) async {
    dynamic result = await Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
    return result;
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void popWidget() {
    Navigator.of(this).pop();
  }
}

extension StringExtensions on String {
  int toInt() {
    return int.tryParse(this) ?? 0;
  }
}

extension DateFormatExtension on String {
  String toCustomDateFormat() {
    // Split the input date string
    List<String> dateParts = split('-');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);

    // Define the month names
    List<String> monthNames = [
      '', // Index 0 is unused for easier month indexing (January is at index 1)
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    // Format the date in "Month day, Year" format
    String formattedDate = "${monthNames[month]} $day, $year";

    return formattedDate;
  }
}
