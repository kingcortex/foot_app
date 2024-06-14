import 'dart:io';

class MyDeviceUtils {
  static double appPadding = 8;

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static bool isIOS() {
    return Platform.isIOS;
  }
}
