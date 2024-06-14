import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:football_app/features/matchs/model/fixtures.dart';
import 'package:football_app/features/matchs/model/team_statistics_in_match.dart';
import 'package:get/get.dart';

import '../../../data/repository/api/api_repository.dart';
import '../model/team.dart';

class DetailMatchScreenController extends GetxController {
  late Fixtures fixtures;
  late Team teamA;
  late Team teamb;
  late TeamStatisticsInMatch statTeamA;
  late TeamStatisticsInMatch statTeamB;

  Rx<LoagingStat> loagingStat = LoagingStat.loading.obs;
  final ApiRepository _apiRepository = Get.find();

  @override
  void onInit() {
    fixtures = Get.arguments;
    getStats();
    super.onInit();
  }

  Future<void> getStats_() async {
    print("get");
    List<TeamStatisticsInMatch>? listStats = await _apiRepository.getStatsMatch(
      parameter: {'fixture': fixtures.fixture.id},
    );
    statTeamA = listStats![0];
    statTeamB = listStats[1];

    loagingStat.value = LoagingStat.done;
  }

  Future<void> getStats() async {
    await Future.delayed(const Duration(seconds: 3));
    final String response =
        await rootBundle.loadString('lib/data/json/stats.json');
    final dynamic data = await json.decode(response);
    List<dynamic> listJson = data["response"];

    List<TeamStatisticsInMatch>? listStats =
        listJson.map((json) => TeamStatisticsInMatch.fromJson(json)).toList();
    statTeamA = listStats[0];
    statTeamB = listStats[1];

    loagingStat.value = LoagingStat.done;
    //print(fixtures.length);
  }
}

enum LoagingStat {
  loading,
  done,
}
