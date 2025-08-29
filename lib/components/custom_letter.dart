import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomLetter extends StatelessWidget {
  const CustomLetter({super.key});
  
  Future<ui.Image> _loadImage(String asset) async {
    final ByteData data = await rootBundle.load(asset);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<ui.Image>(
      future: _loadImage("assets/module_c_pm/media-files/images/Basilique.jpg"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return ui.ImageShader(
                snapshot.data!,
                TileMode.clamp,
                TileMode.clamp,
                (Matrix4.identity()
                ..scale(0.166, .166)
                ..translate(0, snapshot.data!.height / 3)
                ).storage,
              );
            },
            child: const Text(
              'O',
              style: TextStyle(
                fontFamily: "Lyon2",
                fontSize: 350,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
            }
            return const SizedBox(width: 48);
          }
    );
}
}