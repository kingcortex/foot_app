class LeagueC {
  final int id;
  final String name;
  final String type;
  final String logo;

  LeagueC(
      {required this.id,
      required this.name,
      required this.type,
      required this.logo});

  factory LeagueC.fromJson(dynamic json) {
    return LeagueC(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      logo: json['logo'],
    );
  }
}


