import 'package:flutter/material.dart';
import 'package:football_app/features/matchs/controllers/detail_match_screen_controller.dart';
import 'package:football_app/utils/device/device_utility.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/buttons/circle_button.dart';
import '../../../utils/helpers/helper_function.dart';
import '../widget/match_detail_card.dart';

class DetailMatchsPage extends StatelessWidget {
  const DetailMatchsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = MyHelpersFounctions.isDarkMode(context);
    final controller = Get.put(DetailMatchScreenController());
    return Scaffold(
      //extendBody: true,
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 50,
        automaticallyImplyLeading: false,
        leading: CircularButton(
          onTap: () => Get.back(),
          dark: dark,
          icon: Icon(
            Iconsax.arrow_left,
            color: dark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: MyDeviceUtils.appPadding),
            child: CircularButton(
              dark: dark,
              icon: const Icon(Iconsax.more),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MyDeviceUtils.appPadding),
        child: Column(
          children: [
            MatchDetailCard(dark: dark, fixtures: controller.fixtures),
            Obx(
              () => controller.loagingStat.value == LoagingStat.done
                  ? Column(
                      children: controller.statTeamA.statistics!
                          .map((e) => Row(
                                children: [
                                  Text(e.value.toString()),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(e.type!),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ))
                          .toList(),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
