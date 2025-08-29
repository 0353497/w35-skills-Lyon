
import 'package:edu_ws2024_cniek_pm/components/map_view.dart';
import 'package:flutter/material.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Column(
            children: [
              ExpansionTile(title: Text("Things to do")),
              ExpansionTile(title: Text("Budget")),
              ExpansionTile(title: Text("Traveler rating")),
            ],
          ),
        ),
        Flexible(
          flex: 4,
          child: Column(
            spacing: 20,
            children: [
              Expanded(child: MapView()),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recommended to you"),
                        //GridView.count(crossAxisCount: 2),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text("Comments"),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("What is the best time to visit Lyon?"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 5,
                                  children: [
                                    CircleAvatar(),
                                    Text("Olivier")
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 12,
                                  children: [
                                    Container(
                                      width: 2,
                                      height: 100,
                                      color: Colors.grey,
                                    ),
                                    Flexible(child: Text("The best time to visit lyon is during the spring april to ju or autm to september and november when the weather is mild and pleased."))
                                  ],
                                ),
                                Text("998 Likes", textAlign: TextAlign.start,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
