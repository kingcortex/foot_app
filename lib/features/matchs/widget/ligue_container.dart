import 'package:flutter/material.dart';
import 'package:football_app/features/matchs/model/league.dart';
import 'package:football_app/utils/constants/colors.dart';

class LigueContainer extends StatelessWidget {
  final bool isSelected;
  final bool dark;
  final LeagueC league;
  final void Function(int) onTap;
  const LigueContainer({
    super.key,
    required this.dark,
    required this.league,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(league.id),
      child: SizedBox(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                color: dark ? MyColor.containerDark : MyColor.containerLight,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: (league.logo == "all" && dark)
                    ? MyColor.containerDark
                    : MyColor.containerWhite,
                child: league.logo == "all"
                    ? Text(
                        "ALL",
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    : Image.network(
                        height: 30,
                        fit: BoxFit.contain,
                        league.logo,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
              ),
            ),
            if (isSelected)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 249, 243, 243)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 5),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
