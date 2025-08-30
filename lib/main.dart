
import 'package:edu_ws2024_cniek_pm/pages/history_page.dart';
import 'package:edu_ws2024_cniek_pm/pages/homepage.dart';
import 'package:edu_ws2024_cniek_pm/pages/moments_page.dart';
import 'package:edu_ws2024_cniek_pm/pages/recommendation_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Lyon"
      ),
      home: Scaffold(
        backgroundColor: Colors.deepPurple.shade700,
        body: SingleChildScrollView(
          child: Column(
            children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Homepage(),
                ),
              Container(
                color: const Color.fromARGB(255, 46, 14, 100),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: HistoryPages(),
                ),
              Container(
                color: Colors.purple.shade800,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: MomentsPage(),
              ),
               Container(
                color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: RecommendationPage(),
              ),
            ],
          )
          ),
      ),
    );
  }
}
