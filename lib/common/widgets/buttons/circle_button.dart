import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';

class CircularButton extends StatelessWidget {
  final bool dark;
  final Icon icon;
  final void Function()? onTap;
  const CircularButton(
      {super.key, required this.dark, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: MyDeviceUtils.appPadding),
        alignment: Alignment.center,
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: dark ? MyColor.buttonDark : MyColor.buttonlight,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
