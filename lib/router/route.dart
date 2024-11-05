import 'package:football_app/app.dart';
import 'package:football_app/features/matchs/screens/detail_match_screen.dart';
import 'package:get/get.dart';

class RoutesClass {
  static String home = '/';
  static String detailMatch = '/detailMatch';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: detailMatch, page: () => const DetailMatchsPage()),
  ];
}
