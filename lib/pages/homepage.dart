import 'package:edu_ws2024_cniek_pm/components/custom_letter.dart';
import 'package:edu_ws2024_cniek_pm/components/rotated_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          RotatedBlock(alignment: Alignment(0.85, -0.3), blurred: true,).animate(delay: Duration(milliseconds: 2000)).fadeIn().slide(begin: Offset(0.3, -0.3)),
          RotatedBlock(alignment: Alignment(0.1, 0.7), blurred: true,).animate(delay: Duration(milliseconds: 2200)).fadeIn().slide(begin: Offset(0.3, -0.3)),
          RotatedBlock(alignment: Alignment(-0.2, -0.8), blurred: true,).animate(delay: Duration(milliseconds: 2400)).fadeIn().slide(begin: Offset(0.3, -0.3)),
          RotatedBlock(alignment: Alignment(-0.8, -0.7), blurred: true,).animate(delay: Duration(milliseconds: 2600)).fadeIn().slide(begin: Offset(0.3, -0.3)),
          RotatedBlock(alignment: Alignment(-0.9, 0.3), blurred: true,).animate(delay: Duration(milliseconds: 2800)).fadeIn().slide(begin: Offset(0.3, -0.3)),

          Align(
            alignment: Alignment.center,
            child: Text.rich(
              TextSpan(
                text: 'L',
                style: const TextStyle(color: Colors.white, fontSize: 350, fontWeight: FontWeight.bold, fontFamily: "Lyon2"),
                children: <InlineSpan>[
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0, 130),
                      child: const Text(
                        'Y',
                        style: TextStyle(
                          fontSize: 350,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Lyon2"
                        ),
                      ).animate(
                        delay: Duration(milliseconds: 500)
                      ).fadeIn().slide(
                        begin: Offset(0, -0.3),
                        curve: Curves.easeIn
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0, 70),
                      child: CustomLetter()
                      ),
                    ),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0, 130),
                      child: const Text(
                        'N',
                        style: TextStyle(
                          fontSize: 350,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Lyon2"
                        ),
                      ).animate(delay: Duration(milliseconds: 1500)).fadeIn().slide(),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().slide(
              begin: Offset(0, -.3),
              curve: Curves.easeIn
            ),
          ),
          
          RotatedBlock(alignment: Alignment(0.65, 0.65),).animate(delay: Duration(milliseconds: 3000)).fadeIn().slide(begin: Offset(0.3, -0.3)),
          RotatedBlock(alignment: Alignment(0.45, -0.8),).animate(delay: Duration(milliseconds: 3200)).fadeIn().slide(begin: Offset(0.3, -0.3)),
          RotatedBlock(alignment: Alignment(-0.2, 0.55),).animate(delay: Duration(milliseconds: 3400)).fadeIn().slide(begin: Offset(0.3, -0.3)),
          RotatedBlock(alignment: Alignment(-0.8, 0.7)).animate(delay: Duration(milliseconds: 3600)).fadeIn().slide(begin: Offset(0.3, -0.3)),

        ],
      );
  }
}
