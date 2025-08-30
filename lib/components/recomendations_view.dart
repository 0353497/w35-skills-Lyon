import 'package:edu_ws2024_cniek_pm/utils/json.dart';
import 'package:flutter/material.dart';

class RecomendationsView extends StatelessWidget {
  const RecomendationsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: loadRecommendedData(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (asyncSnapshot.hasError) {
          return Center(child: Text('Error: ${asyncSnapshot.error}'));
        }
        
        return SizedBox(
          height: 380,
          child: GridView.count(
            crossAxisCount: 2, 
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: asyncSnapshot.data?.map<Widget>((element) => 
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/module_c_pm/media-files/images/${element["image"]}", 
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87,
                        ],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 15,
                    right: 15,
                    child: Text(
                      element['title'] ?? 'No title',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    right: 15,
                    child: Text(
                      element['tag'] ?? 'no tag',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ).toList() ?? [],
          ),
        );
      }
    );
  }

  Future<List<Map<String, dynamic>>> loadRecommendedData() async {
    final List<Map<String, dynamic>> data = await JsonReader.readJson("assets/module_c_pm/media-files/data/recommends.json");
    return data;
  }
}