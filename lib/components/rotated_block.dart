import 'dart:ui';

import 'package:flutter/material.dart';

class RotatedBlock extends StatelessWidget {
  const RotatedBlock({super.key, this.blurred = false, required this.alignment});
  final bool blurred;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Transform.rotate(
        angle: 120,
        child: BackdropFilter(
          enabled: blurred,
          backdropGroupKey: BackdropKey(),
          filter: 
          ImageFilter.blur(sigmaX: 5, sigmaY: 5, tileMode: TileMode.decal),
          child: Container(
            width: 16,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
          ),
        ),
      ),
    );
  }
}