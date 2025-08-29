import 'package:edu_ws2024_cniek_pm/components/custom_letter.dart';
import 'package:edu_ws2024_cniek_pm/components/rotated_block.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          RotatedBlock(alignment: Alignment(0.1, 0.7), blurred: true,),
          RotatedBlock(alignment: Alignment(-0.8, -0.7), blurred: true,),
          RotatedBlock(alignment: Alignment(-0.2, -0.8), blurred: true,),
          RotatedBlock(alignment: Alignment(0.85, -0.3), blurred: true,),
          RotatedBlock(alignment: Alignment(-0.9, 0.3), blurred: true,),


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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          RotatedBlock(alignment: Alignment(-0.8, 0.7)),
          RotatedBlock(alignment: Alignment(0.65, 0.65),),
          RotatedBlock(alignment: Alignment(0.45, -0.8),),
          RotatedBlock(alignment: Alignment(-0.2, 0.55),),

        ],
      );
  }
}
