import 'package:football_app/features/matchs/model/team.dart';

class TeamStatisticsInMatch {
  Team? team;
  List<Statistic>? statistics;

  TeamStatisticsInMatch({
    this.team,
    this.statistics,
  });

  factory TeamStatisticsInMatch.fromJson(Map<String, dynamic> json) =>
      TeamStatisticsInMatch(
        team: json["team"] == null ? null : Team.fromJson(json["team"]),
        statistics: json["statistics"] == null
            ? []
            : List<Statistic>.from(
                json["statistics"]!.map((x) => Statistic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "team": team?.toJson(),
        "statistics": statistics == null
            ? []
            : List<dynamic>.from(statistics!.map((x) => x.toJson())),
      };
}

class Statistic {
  String? type;
  dynamic value;

  Statistic({
    this.type,
    this.value,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}
