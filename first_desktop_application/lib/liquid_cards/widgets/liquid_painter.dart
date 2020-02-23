import 'dart:math';

import 'package:flutter/material.dart';

class LiquidSimulation {
  int curveCount = 4;

  List<Offset> ctrlPts = [];
  List<Offset> endPts = [];

  List<Animation<double>> ctrlTweens = [];
  final ElasticOutCurve _ease = ElasticOutCurve(.3);

  // Y beause we animating the y-axis...
  void start(AnimationController controller, bool flipY) {
    controller.addListener(_updateControlPointsFromTweens);

    // Always 4..
    for (var i = 0; i < curveCount; i++) {
      // Randomize this variable....
      var height = (.5 + Random().nextDouble() * .5) *
          (i % 2 == 0 ? 1 : -1) *
          (flipY ? -1 : 1);

      var animSequence = TweenSequence([
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 0),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: height).chain(
            CurveTween(curve: Curves.linear),
          ),
          weight: 10.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: height, end: 0).chain(
            CurveTween(curve: _ease),
          ),
          weight: 60.0,
        )
      ]).animate(controller);

      ctrlTweens.add(animSequence);

      debugPrint('$height');
    }
  }

  List<Offset> _updateControlPointsFromTweens() {
    for (var i = 0; i < ctrlPts.length; i++) {
      var o = ctrlPts[i];

      ctrlPts[i] = Offset(o.dx, ctrlTweens[i].value);
    }

    print('>>>>> ${ctrlPts} ${ctrlPts.length} ');
    return ctrlPts;
  }
}

class LiquidPainter extends CustomPainter {
  final double fillLevel;
  final LiquidSimulation simulation1;
  final LiquidSimulation simulation2;
  final double waveHeight;

  LiquidPainter(
    this.fillLevel,
    this.simulation1,
    this.simulation2, {
    this.waveHeight = 200,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawLiquidSim(
      simulation1,
      canvas,
      size,
      0,
      Color(0xffC48D3B).withOpacity(.4),
    );
    _drawLiquidSim(
      simulation2,
      canvas,
      size,
      5,
      Color(0xff9D7B32).withOpacity(.4),
    );
  }

  //TODO: FILL THIS >>>>
  void _drawLiquidSim(
    LiquidSimulation simulation,
    Canvas canvas,
    Size size,
    double offsetY,
    Color color,
  ) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
