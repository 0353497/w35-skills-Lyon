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
  late AnimationController _progressController;
  late AnimationController _carouselController;
  late AnimationController _textController;
  late Animation<double> _expandAnimation;
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
    _progressController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    
    _carouselController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    _expandAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _carouselController,
      curve: Curves.easeInOut,
    ));
    
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextSlide();
      }
    });
  }

  void _startAutoProgress() {
    _progressController.forward();
  }

  void _nextSlide() {
    if (mounted) {
      _textController.forward().then((_) {
        _carouselController.forward().then((_) {
          setState(() {
            currentIndex = (currentIndex + 1) % historyData.length;
          });
          
          _carouselController.reset();
          _textController.reverse();
          _progressController.reset();
          _progressController.forward();
        });
      });
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    _carouselController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Widget _buildImageCarousel() {
    if (historyData.isEmpty) return SizedBox();
    
    return Container(
      height: 400,
      width: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Container(
              width: 600,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/module_c_pm/media-files/images/${historyData[currentIndex]['image']}'
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            AnimatedBuilder(
              animation: _expandAnimation,
              builder: (context, child) {
                int nextIndex = (currentIndex + 1) % historyData.length;
                return Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 600 * _expandAnimation.value,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/module_c_pm/media-files/images/${historyData[nextIndex]['image']}'
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentContent() {
    if (historyData.isEmpty) return SizedBox();
    final currentHistory = historyData[currentIndex];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentHistory['phase'],
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentHistory['time_range'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: Text(
                currentHistory['intro'],
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                  SizedBox(height: 20),
                  
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
                                        borderRadius: BorderRadius.circular(8),
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
                  
                  SizedBox(height: 30),
                  
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImageCarousel(),
                        _buildCurrentContent(),
                      ],
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