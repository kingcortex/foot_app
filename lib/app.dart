import 'package:flutter/material.dart';
import 'package:football_app/router/route.dart';
import 'package:get/get.dart';

import 'features/matchs/screens/matchs_sreen.dart';
import 'utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RoutesClass.home,
      getPages: RoutesClass.routes,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          PageView(
            children: const [
              MatchsScreen(),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.only(bottom: 25.0),
          //     child: Container(
          //       height: 60,
          //       width: 200,
          //       decoration: BoxDecoration(
          //         color: Colors.grey.withOpacity(0.1),
          //         borderRadius: BorderRadius.circular(50),
          //       ),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(50),
          //         child: BackdropFilter(
          //             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //             child: Row(
          //               children: [
          //                 Container(
          //                   height: 50,
          //                   width: 130,
          //                   decoration: BoxDecoration(
          //                     color: Colors.white,
          //                     borderRadius: BorderRadius.circular(50),
          //                   ),
          //                 )
          //               ],
          //             )),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      drawer: const Drawer(
        child: Center(
          child: Text("Setting"),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_baseball_outlined), label: "Match"),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: "News"),
        ],
      ),
    );
  }
}
