import 'package:flutter/material.dart';
import 'package:football_app/utils/extentions/gap.dart';
import 'package:football_app/utils/formater/formater_date.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';

class CalendarButton extends StatelessWidget {
  final bool dark;
  final DateTime dateTime;
  final void Function()? onTap;
  const CalendarButton(
      {super.key, required this.dark, this.onTap, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: MyDeviceUtils.appPadding),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
            color: dark ? MyColor.buttonDark : MyColor.buttonlight,
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            const Icon(Iconsax.calendar_1),
            10.V,
            Text(
              formatDateForCalendarButton(dateTime),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            10.V,
            const Icon(Iconsax.arrow_down_1)
          ],
        ),
      ),
    );
  }
}
