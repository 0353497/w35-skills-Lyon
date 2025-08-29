import 'package:flutter/material.dart';
import 'dart:async';

class MomentsPage extends StatefulWidget {
  const MomentsPage({super.key});

  @override
  State<MomentsPage> createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  late AnimationController _animationController;
  Timer? _scrollTimer;

  // Define the list of moment indices for each column
  final List<int> _column1Moments = [1, 2, 3, 4, 5];
  final List<int> _column2Moments = [6, 7, 8, 9, 10];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController2.hasClients) {
        _scrollController2.jumpTo(_scrollController2.position.maxScrollExtent);
      }
    });
    
    _startContinuousAnimation();
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Center(
            child: Padding(
              padding: EdgeInsetsGeometry.fromLTRB(50, 50, 50, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Text.rich(
                    textAlign: TextAlign.start,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Unforgettable \nMoments in ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lyon",
                          ),
                        ),
                        TextSpan(
                          text: "Lyon ",
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Lyon",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: Text(
                      "Lyon, the third-largest city in France, is a charming destination that offers a rich blend of history, cultur, and culinary delights, Nestled in the heart of the Rhone-Alpes region, this vibrant city boasts a stunning landscap, with the Rhone and Saone rivers meandering through its streets, As you explore Lyon, you'll uncover an array of unforgettable moments that will leave a lasting impression on your heart.",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text(
                            "5.5M+",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            "Visitors",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        spacing: 5,
                        children: [
                          Text(
                            "10.2M+",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          Text(
                            "Photography",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    width: 130,
                    child: TextButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8))),
                      backgroundColor: WidgetStatePropertyAll(Colors.pink),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      padding: WidgetStatePropertyAll(EdgeInsets.all(4)),
                    ),  
                    onPressed: () {
                    
                    }, child: Text("Explore")
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: ClipRect(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _scrollController,
                        itemCount: 1000, // officieel niet oneindig, maar als jij uren wil wachten (zonder te verversen), is het jouw keuze
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: MomentCard(
                              constraints: constraints,
                              index: _column1Moments[index % _column1Moments.length],
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _scrollController2,
                        itemCount: 1000,
                        itemBuilder: (context, index) {
                          return Transform.translate(
                            offset: Offset(0, index == 0 ? constraints.maxHeight / 3 : 0),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: MomentCard(
                                constraints: constraints,
                                index: _column2Moments[index % _column2Moments.length],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }

  void _startContinuousAnimation() {
    _scrollTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (_scrollController.hasClients && _scrollController2.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        double currentScrollPosition = _scrollController.offset;

        if (currentScrollPosition >= maxScrollExtent) {
          _scrollController.jumpTo(0);
          _scrollController2.jumpTo(_scrollController2.position.maxScrollExtent);
        } else {
          _scrollController2.animateTo(
            _scrollController2.offset - 3.0,
            duration: Duration(milliseconds: 50),
            curve: Curves.linear,
          );
          _scrollController.animateTo(
            currentScrollPosition + 3.0,
            duration: Duration(milliseconds: 50),
            curve: Curves.linear,
          );
        }
      }
    });
  }
}

class MomentCard extends StatelessWidget {
  const MomentCard({
    super.key,
    required this.constraints,
    required this.index,
  });
  final BoxConstraints constraints;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 8),
      ),
      height: constraints.maxHeight / 3 * 1.2,
      width: (constraints.maxWidth / 2) - 20,
      child: Image.asset(
        "assets/module_c_pm/media-files/images/moments/moment-$index.jpeg",
        fit: BoxFit.cover,
      ),
    );
  }
}