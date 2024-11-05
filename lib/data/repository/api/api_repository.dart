import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:football_app/features/matchs/model/fixtures.dart';
import 'package:football_app/features/matchs/model/team_statistics_in_match.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ApiRepository extends GetxController {
  final Completer<void> _dioInitialized = Completer<void>();

  @override
  void onInit() {
    _initializeDio();
    super.onInit();
  }

  String _API_KEY = "59db73280785309c6d97c05cf82415fc";
  String url = "https://v3.football.api-sports.io";
  Dio? _dio;

  Future<void> _initializeDio() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cacheStore = HiveCacheStore(appDocDir.path);

    final options = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      priority: CachePriority.high,
      maxStale: const Duration(days: 7),
      keyBuilder: CacheOptions.defaultCacheKeyBuilder, 
      allowPostMethod: false,
    );

    _dio = Dio(BaseOptions(
      baseUrl: url,
      headers: {
        'x-apisports-key': _API_KEY,
      },
      connectTimeout: const Duration(minutes: 2),
      sendTimeout: const Duration(minutes: 2),
    ))
      ..interceptors.add(DioCacheInterceptor(options: options));

    _dioInitialized.complete();
  }

  Future<List<Fixtures>?> getFixtures({Map<String, dynamic>? parameter}) async {
    await _dioInitialized.future; // Wait for Dio to be initialized
    try {
      var response = await _dio!.get(
        "/fixtures",
        queryParameters: parameter,
        options: Options(extra: {'refresh': false}),
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
    await _dioInitialized.future; // Wait for Dio to be initialized
    try {
      var response = await _dio!.get(
        "/fixtures/statistics?",
        queryParameters: parameter,
        options: Options(extra: {'refresh': false}),
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
