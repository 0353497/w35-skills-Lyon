import 'package:edu_ws2024_cniek_pm/components/map_view.dart';
import 'package:edu_ws2024_cniek_pm/components/recomendations_view.dart';
import 'package:edu_ws2024_cniek_pm/utils/json.dart';
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

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  List<Map<String, dynamic>> comments = [];
  bool isLoading = true;
  bool isMapExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    try {
      final loadedComments = await JsonReader.readJson('assets/module_c_pm/media-files/data/comments.json');
      setState(() {
        comments = loadedComments;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _toggleMapExpansion() {
    setState(() {
      isMapExpanded = !isMapExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isMapExpanded ? 0 : MediaQuery.of(context).size.width * 0.2,
                child: Visibility(
                  visible: !isMapExpanded,
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
              ),
              Expanded(
                child: Column(
                  children: [

                    //ik had hier beter eigenlijk een hero widget voor kunnen gebruiken..
                    //maar dat besef je natuurlijk later...
                    Expanded(
                      flex: isMapExpanded ? 1 : 3,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: MapView(
                          isExpanded: isMapExpanded,
                          onToggleExpansion: _toggleMapExpansion,
                        ),
                      ),
                    ),
                    if (!isMapExpanded)
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
                                        child: isLoading
                                          ? Center(child: CircularProgressIndicator())
                                          : SingleChildScrollView(
                                              child: Column(
                                                spacing: 16,
                                                children: comments.map((comment) => CommentCard(
                                                  question: comment['question'] ?? '',
                                                  answer: comment['answer'] ?? '',
                                                  username: comment['username'] ?? '',
                                                  likes: comment['likes'] ?? 0,
                                                )).toList(),
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

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.question,
    required this.answer,
    required this.username,
    required this.likes,
  });

  final String question;
  final String answer;
  final String username;
  final int likes;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
            Text(question,
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
                  child: Text(username.isNotEmpty ? username[0].toUpperCase() : "?", 
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
                    Text(username,
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
              child: Text(answer,
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
                    Text("$likes Likes", 
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


