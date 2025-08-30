import 'package:edu_ws2024_cniek_pm/components/map_view.dart';
import 'package:edu_ws2024_cniek_pm/components/recomendations_view.dart';
import 'package:flutter/material.dart';

class CustomRangeSliderThumbShape extends RangeSliderThumbShape {
  const CustomRangeSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius = 6.0,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });

  final double enabledThumbRadius;
  final double disabledThumbRadius;
  final double elevation;
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
      isEnabled ? enabledThumbRadius : disabledThumbRadius,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final double radius = enabledThumbRadius;

    final Paint outerPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, outerPaint);

    final Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 4, innerPaint);
  }
}

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExpansionTile(
                      title: Text("Things to do",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      initiallyExpanded: true,
                      children: [
                        Wrap(
                          children: [
                              OwnChip(label: "Walking",),
                              OwnChip(label: "Half-day",),
                              OwnChip(label: "Culinary",),
                              OwnChip(label: "Historic Walking Areas",),
                              OwnChip(label: "Historical",),
                              OwnChip(label: "Wine Tastings",),
                              OwnChip(label: "Architectural Buildings",),
                            ],
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Budget",
                       style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      initiallyExpanded: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            spacing: 20,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  OwnChip(label: "\$500"),
                                  OwnChip(label: "\$800"),
                                ],
                              ),
                              SliderTheme(
                                data: SliderThemeData(
                                  thumbColor: Colors.white, 
                                  overlayColor: Colors.grey,
                                  activeTrackColor: Colors.black, 
                                  inactiveTrackColor: Colors.grey,
                                  thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 12.0,
                                    pressedElevation: 0,
                                    elevation: 0,
                                  ),
                                  rangeThumbShape: CustomRangeSliderThumbShape(
                                    enabledThumbRadius: 12.0,
                                    pressedElevation: 0,
                                    elevation: 0,
                                  ),
                                  trackHeight: 4.0,
                                  overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: RangeSlider(
                                    overlayColor: WidgetStatePropertyAll(Colors.black12),
                                    activeColor: Colors.black,
                                    inactiveColor: Colors.grey,
                                    min: 0,
                                    max: 1000,
                                    onChanged: (values) {
                                    },
                                    values: RangeValues(500, 800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Traveler rating",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      initiallyExpanded: true,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StarInput(rating: 5,),
                        StarInput(rating: 4,),
                        StarInput(rating: 3,),
                        StarInput(rating: 2,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: MapView()
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            spacing: 5,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Recommended to you",
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 26,
                                fontWeight: FontWeight.w600
                              ),
                              ),
                              Expanded(child: RecomendationsView()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Text("Comments",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      spacing: 16,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black87,
                                                blurRadius: 8,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("What is the best time to visit Lyon?",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                  color: Colors.black87,
                                                ),
                                                ),
                                                SizedBox(height: 12),
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 16,
                                                      child: Text("O", 
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12
                                                        )
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Olivier",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 13,
                                                            color: Colors.black87
                                                          )
                                                        ),
                                                        Text("Travel Expert",
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: Colors.grey[600]
                                                          )
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 12),
                                                Container(
                                                  padding: EdgeInsets.only(left: 12),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: Colors.black,
                                                        width: 3,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text("The best time to visit Lyon is during the spring (April to June) or autumn (September to November) when the weather is mild and pleasant.",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[700],
                                                      height: 1.4,
                                                    )
                                                  ),
                                                ),
                                                SizedBox(height: 12),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.favorite_border, 
                                                          size: 16, 
                                                          color: Colors.grey[600]
                                                        ),
                                                        SizedBox(width: 4),
                                                        Text("998 Likes", 
                                                          style: TextStyle(
                                                            color: Colors.grey[600],
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text("2 days ago", 
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontSize: 11
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Add more comment cards here if needed
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StarInput extends StatelessWidget {
  const StarInput({
    super.key, required this.rating,
  });
  final int rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          activeColor: Colors.grey,
          overlayColor: WidgetStatePropertyAll(Colors.grey),
          value: true, groupValue: false, onChanged: (newValue){
        }),
        Row(
          children: [
            Icon(Icons.star, color: Colors.yellow,),
            Icon(
              rating <= 1 ? Icons.star_border :
              Icons.star, color: Colors.yellow,),
            Icon(
              rating <= 2 ? Icons.star_border :
              Icons.star, color: Colors.yellow,),
            Icon(
              rating <= 3 ? Icons.star_border :
              Icons.star, color: Colors.yellow,),
            Icon(
              rating <= 4? Icons.star_border :
              Icons.star, color: Colors.yellow,),
            if (rating < 5)
            Text("& up", 
            style: TextStyle(
              color: Colors.grey
            ),
            )
          ],
        )
      ],
    );
  }
}

class OwnChip extends StatelessWidget {
  const OwnChip({
    super.key, required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: Colors.grey,
            width: 0.75
          )
        ),
        backgroundColor: Colors.white,
        label: Text(label,),
        ),
    );
  }
}


