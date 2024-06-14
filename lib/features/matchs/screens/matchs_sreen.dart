

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_app/common/widgets/buttons/calendar_button.dart';
import 'package:football_app/common/widgets/buttons/circle_button.dart';
import 'package:football_app/features/matchs/controllers/match_screen_controller.dart';
import 'package:football_app/features/matchs/widget/ligue_container.dart';
import 'package:football_app/features/matchs/widget/match_card.dart';
import 'package:football_app/utils/constants/colors.dart';
import 'package:football_app/utils/device/device_utility.dart';
import 'package:football_app/utils/extentions/gap.dart';
import 'package:football_app/utils/helpers/helper_function.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MatchsScreen extends StatefulWidget {
  const MatchsScreen({super.key});

  @override
  State<MatchsScreen> createState() => _MatchsScreenState();
}

class _MatchsScreenState extends State<MatchsScreen> {
  MatchScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    bool dark = MyHelpersFounctions.isDarkMode(context);
    return Scaffold(
      //extendBody: true,
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: CircularButton(
          onTap: () => Scaffold.of(context).openDrawer(),
          dark: dark,
          icon: Icon(
            Iconsax.setting_2,
            color: dark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          Obx(
            () => CalendarButton(
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      DateTime selectedDate = controller.date.value;
                      return Container(
                        color: dark
                            ? MyColor.containerDark
                            : MyColor.containerLight,
                        height: 350,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CupertinoButton(
                                    child: Text(
                                      "Done",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    onPressed: () {
                                      controller.changeDate(selectedDate);
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: selectedDate,
                                onDateTimeChanged: (dateTime) {
                                  selectedDate = dateTime;
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              dark: dark,
              dateTime: controller.date.value,
            ),
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: FutureBuilder(
                  future: controller.getLeagues(),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: SizedBox(
                        height: 75,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: controller.leagues.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Obx(
                            () => LigueContainer(
                              onTap: (id) => controller.changeLeague(id),
                              isSelected: controller.leagues[index].id ==
                                  controller.leagueSelected.value,
                              dark: dark,
                              league: controller.leagues[index],
                            ),
                          ),
                          separatorBuilder: (context, index) => 10.V,
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
        body: Obx(() {
          switch (controller.loagingMatch.value) {
            case LoagingMatch.done:
              return ListView.separated(
                padding: EdgeInsets.only(
                    left: MyDeviceUtils.appPadding,
                    right: MyDeviceUtils.appPadding,
                    bottom: 20),
                itemCount: controller.fixtures!.length,
                itemBuilder: (context, index) {
                  return MatchCard(
                      dark: dark, fixtures: controller.fixtures![index]);
                },
                separatorBuilder: (context, index) => 5.H,
              );
            case LoagingMatch.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        }),
      ),
    );
  }
}
