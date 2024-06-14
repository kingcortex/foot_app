import 'package:dio/dio.dart';
import 'package:football_app/features/matchs/model/fixtures.dart';
import 'package:football_app/features/matchs/model/team_statistics_in_match.dart';
import 'package:get/get.dart';

class ApiRepository extends GetxController {
  static const String _API_KEY = "59db73280785309c6d97c05cf82415fc";
  Options options = Options(
    headers: {
      'x-apisports-key': _API_KEY,
    },
  );
  String url = "https://v3.football.api-sports.io";
  final _dio = Dio();

  Future<List<Fixtures>?> getFixtures({Map<String, dynamic>? parameter}) async {
    try {
      var response = await _dio.get(
        "$url/fixtures",
        queryParameters: parameter,
        options: options,
      );
      if (response.statusCode == 200) {
        List data = response.data["response"];
        List<Fixtures>? listFixtures =
            data.map((json) => Fixtures.fromJson(json)).toList();
        print(listFixtures.length);
        return listFixtures;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<TeamStatisticsInMatch>?> getStatsMatch(
      {Map<String, dynamic>? parameter}) async {
    try {
      var response = await _dio.get(
        "$url/fixtures/statistics?",
        queryParameters: parameter,
        options: options,
      );
      print(response.data);
      if (response.statusCode == 200) {
        List data = response.data["response"];
        List<TeamStatisticsInMatch>? listTeamStatisticsInMatch =
            data.map((json) => TeamStatisticsInMatch.fromJson(json)).toList();
        return listTeamStatisticsInMatch;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
