import 'package:flutter/material.dart';
import '../utils/json.dart';

class HistoryPages extends StatefulWidget {
  const HistoryPages({super.key});

  @override
  State<HistoryPages> createState() => _HistoryPagesState();
}

class _HistoryPagesState extends State<HistoryPages> with TickerProviderStateMixin {
  List<Map<String, dynamic>> historyData = [];
  bool isLoading = true;
  late TabController _tabController;
  late AnimationController _progressController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadHistoryData();
  }

  Future<void> loadHistoryData() async {
    try {
      final data = await JsonReader.readJson('assets/module_c_pm/media-files/data/histories.json');
      setState(() {
        historyData = data;
        isLoading = false;
      });
      
      if (data.isNotEmpty) {
        _initializeControllers();
        _startAutoProgress();
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error loading history data: $e');
    }
  }

  void _initializeControllers() {
    _tabController = TabController(length: historyData.length, vsync: this);
    _progressController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextTab();
      }
    });
  }

  void _startAutoProgress() {
    _progressController.forward();
  }

  void _nextTab() {
    setState(() {
      currentIndex = (currentIndex + 1) % historyData.length;
    });
    
    _tabController.animateTo(currentIndex);
    _progressController.reset();
    _progressController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("History of Lyon",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 48,
              fontFamily: "Lyon2"
            ),
          ),
      
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Lyon is the ancient",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: "Lyon"
                  ),
                ),
                TextSpan(
                  text: " capitol of Gaul",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 26,
                    fontFamily: "Lyon"
                  ),
                ),
                TextSpan(
                  text: "\nwith a rich history of",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: "Lyon"
                  ),
                ),
                 TextSpan(
                  text: " more than 2000 years.",
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 26,
                    fontFamily: "Lyon"
                  ),
                ),
              ]
            ),
          ),
      
          if (isLoading)
            CircularProgressIndicator(color: Colors.white)
          else if (historyData.isNotEmpty)
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(historyData.length, (index) {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              spacing: 8,
                              children: [
                                Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.grey,
                                  ),
                                  child: AnimatedBuilder(
                                    animation: _progressController,
                                    builder: (context, child) {
                                      double progress = 0.0;
                                      if (index < currentIndex) {
                                        progress = 1.0;
                                      } else if (index == currentIndex) {
                                        progress = _progressController.value;
                                      }
                                      
                                      return LinearProgressIndicator(
                                        value: progress,
                                        backgroundColor: Colors.transparent,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          index == currentIndex ? Colors.white : Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                 Text(
                                  historyData[index]['phase'],
                                  style: TextStyle(
                                    color: index == currentIndex ? Colors.white : Colors.grey,
                                    fontSize: 12,
                                    fontWeight: index == currentIndex ? FontWeight.bold : FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: historyData.map((history) => 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                              if (history['image'] != null)
                                  Container(
                                    height: 400,
                                    width: 600,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: AssetImage('assets/module_c_pm/media-files/images/${history['image']}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              history['phase'],
                                              style: TextStyle(
                                                color: Colors.pink,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              history['time_range'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                        ),
                                         Text(
                                          history['intro'],
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ).toList(),
                    ),
                  ),
                ],
              ),
            )
          else
            Text(
              'No history data available',
              style: TextStyle(color: Colors.white),
            ),
        ],
      ),
    );
  }
}