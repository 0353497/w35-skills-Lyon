

import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: MediaQuery.of(context).size.height / 3 + 100,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26)
        ),
        child: Stack(
          children: [
            InteractiveViewer(
              minScale: 2.5,
              maxScale: 4,
              child: Image.asset("assets/module_c_pm/media-files/images/map.jpg", fit: BoxFit.cover, width: double.infinity,),
              ),
            Positioned(
              right: 20,
              bottom: 20,
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  
              },
              icon: Image.asset("assets/module_c_pm/media-files/icons/open_in_full.png", fit: BoxFit.contain, width: 20,)),
            )
          ],
        ),
      ),
    );
  }
}