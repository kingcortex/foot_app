import 'package:flutter/material.dart';
import 'package:football_app/data/repository/api/api_repository.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'features/matchs/controllers/match_screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ApiRepository());
  final controller = Get.put(MatchScreenController());
  controller.getFixtures();
  runApp(const MyApp());
}
