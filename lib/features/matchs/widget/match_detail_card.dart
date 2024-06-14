import 'package:flutter/material.dart';
import 'package:football_app/features/matchs/model/fixtures.dart';
import 'package:football_app/utils/extentions/gap.dart';
import 'package:football_app/utils/formater/formater_date.dart';

import '../../../utils/constants/colors.dart';

class MatchDetailCard extends StatefulWidget {
  final bool dark;
  final Fixtures fixtures;
  const MatchDetailCard(
      {super.key, required this.dark, required this.fixtures});

  @override
  State<MatchDetailCard> createState() => _MatchDetailCardState();
}

class _MatchDetailCardState extends State<MatchDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.dark ? MyColor.containerDark : MyColor.containerLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTeam(
              name: widget.fixtures.teams.home['name'],
              logo: widget.fixtures.teams.home['logo']),
          if (widget.fixtures.fixture.status.long == Long.MATCH_FINISHED)
            buildScore(),
          if (widget.fixtures.fixture.status.long == Long.NOT_STARTED)
            buildDateMatch(),
          if (widget.fixtures.fixture.status.long == Long.MATCH_CANCELLED)
            buildMatchCancel(),
          if (widget.fixtures.fixture.status.long == Long.MATCH_POSTPONED)
            buildMatchPostponed(),
          // Text(
          //   widget.fixtures.fixture.status.long.toString(),
          //   style: TextStyle(fontSize: 12),
          // ),
          buildTeam(
            name: widget.fixtures.teams.away['name'],
            logo: widget.fixtures.teams.away['logo'],
          ),
        ],
      ),
    );
  }

  Widget buildTeam({String? name, String? logo}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          radius: 30,
          child: Image.network(
            height: 55,
            fit: BoxFit.contain,
            logo!,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
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
        10.H,
        SizedBox(
          height: 40,
          width: 100,
          child: Text(
            textAlign: TextAlign.center,
            name ?? "null",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
      ],
    );
  }

  Widget buildScore() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text(
        //   "56'",
        //   style: Theme.of(context)
        //       .textTheme
        //       .bodyLarge!
        //       .copyWith(color: const Color(0xff16bb18)),
        // ),
        Row(
          children: [
            Text(
              widget.fixtures.score.fulltime.home.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            5.V,
            Text(
              "-",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            5.V,
            Text(
              widget.fixtures.score.fulltime.away.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 9, 112, 12)),
          child: Text(
            "FINISHED",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 12, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget buildMatchCancel() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: const BoxDecoration(color: Color.fromARGB(255, 236, 107, 98)),
      child: Text(
        "CANCELLED",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget buildMatchPostponed() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 226, 159, 155)),
      child: Text(
        "POSTPONED",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget buildDateMatch() {
    return Text(
      extractTime(widget.fixtures.fixture.date.toString()),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
