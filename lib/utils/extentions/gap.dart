import 'package:flutter/material.dart';

extension IntExtention on int {
  SizedBox get H => SizedBox(height: toDouble());
  SizedBox get V => SizedBox(width: toDouble());
}
