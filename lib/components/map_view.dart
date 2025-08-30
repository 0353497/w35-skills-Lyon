import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  const MapView({
    super.key,
    required this.isExpanded,
    required this.onToggleExpansion,
  });

  final bool isExpanded;
  final VoidCallback onToggleExpansion;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 
      widget.isExpanded 
      ? const EdgeInsets.all(0) :
      const EdgeInsets.all(24.0),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: InteractiveViewer(
                  minScale: 2.5,
                  maxScale: 4,
                  child: Image.asset(
                    "assets/module_c_pm/media-files/images/map.jpg", 
                    fit: BoxFit.cover, 
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              if (widget.isExpanded)
              Positioned(
                left: 20,
                top: 30,
                child: SizedBox(
                  width: 400,
                  child: SearchAnchor.bar(
                    barHintText: "Search",
                    viewLeading: SizedBox(),
                    barLeading: SizedBox(),
                    viewTrailing: [
                      Icon(Icons.search, color: Colors.pink,)
                    ],
                    barTrailing: [
                      Icon(Icons.search, color: Colors.pink,)
                    ],
                   suggestionsBuilder: (context, controller) {
                    return [
                     ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text("Basilique Notre Dame de Fourvisdsfasdf"),
                     ),
                     ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text("Musee du Cinema et de la Miniature iets moet hier"),
                     ),
                    ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text("Vieux Lyon"),
                     ),
                    ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text("Parc de la Tete d' Or"),
                     ),
                    ListTile(
                      leading: Icon(Icons.schedule),
                      title: Text("Les Halles de Lyon Paul Bocuse"),
                     ),
                    ];
                   },
                  ),
                )
                ),
              
              Positioned(
                right: 20,
                bottom: 20,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: widget.onToggleExpansion,

                  icon: 
                  widget.isExpanded ?
                  Image.asset("assets/module_c_pm/media-files/icons/close_fullscreen.png", fit: BoxFit.contain, width: 20,)
                   :
                  Image.asset("assets/module_c_pm/media-files/icons/open_in_full.png", fit: BoxFit.contain, width: 20,)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}