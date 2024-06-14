import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:football_app/data/repository/api/api_repository.dart';
import 'package:football_app/features/matchs/model/league.dart';
import 'package:football_app/utils/formater/formater_date.dart';
import 'package:get/get.dart';

import '../model/fixtures.dart';

class MatchScreenController extends GetxController {
  List<LeagueC> leagues = [
    LeagueC(id: 0, name: "all", type: "all", logo: "all")
  ];
  RxInt leagueSelected = 0.obs;
  Rx<DateTime> date = DateTime.now().obs;
  List<Fixtures>? fixtures = [];

  Rx<LoagingMatch> loagingMatch = LoagingMatch.loading.obs;
  Map<String, dynamic>? params;
  final ApiRepository _apiRepository = Get.find();

  @override
  void onInit() {
    params = {'date': formatDateForApi(date.value)};
    super.onInit();
  }

  void changeLeague(int id) {
    if (id != leagueSelected.value) {
      leagueSelected.value = id;
      if (id == 0) {
        params!.remove('league');
        params!.remove('season');
      } else {
        params!.addAll({'league': id, 'season': 2023});
      }
      getFixtures();
    }
  }

  void changeDate(DateTime dateTime) {
    if (dateTime != date.value) {
      date.value = dateTime;
      params!['date'] = formatDateForApi(date.value);
      loagingMatch.value = LoagingMatch.loading;
      getFixtures();
    }
  }

  Future<void> getLeagues() async {
    final String response =
        await rootBundle.loadString('lib/data/json/league_on_my_app.json');
    final List<dynamic> data = await json.decode(response);

    leagues.addAll(data.map((json) => LeagueC.fromJson(json)));
    leagueSelected = leagues[0].id.obs;
  }
  List number = [1, 3, 5];
  

  Future<void> getFixtures_() async {
    loagingMatch.value = LoagingMatch.loading;
    fixtures = await _apiRepository.getFixtures(parameter: params);

    loagingMatch.value = LoagingMatch.done;

    //print(fixtures.length);
  }

  Future<void> getFixtures() async {
    await Future.delayed(const Duration(seconds: 3));
    final String response =
        await rootBundle.loadString('lib/data/json/fixtures_test.json');
    final dynamic data = await json.decode(response);
    List<dynamic> listJson = data["response"];

    fixtures = listJson.map((json) => Fixtures.fromJson(json)).toList();
    loagingMatch.value = LoagingMatch.done;

    //print(fixtures.length);
  }
}

enum LoagingMatch {
  loading,
  done,
}
