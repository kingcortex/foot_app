import 'package:flutter/material.dart';

class MyHelpersFounctions {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
