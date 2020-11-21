import 'dart:math';

import 'package:flutter/material.dart';

class LiquidSimulation {
  int curveCount = 4;

  // FILLED IN _updateControlPointsFromTweens fxn... Reqd for QBC
  List<Offset> ctrlPts = [];
  List<Offset> endPts = []; // FILLED IN start fxn... Reqd for QBC

  List<Animation<double>> ctrlTweens = [];
  final ElasticOutCurve _ease = const ElasticOutCurve(.3);

  double hzScale;
  double hzOffset;

  // Y beause we animating the y-axis...
  // ignore: avoid_positional_boolean_parameters
  void start(AnimationController controller, bool flipY) {
    controller.addListener(_updateControlPointsFromTweens);

    // Calculate gap between each ctrl/end pt....1/8 = 0.125
    final gap = 1 / (curveCount * 2.0);

    // Randomly scale and offset each simulation, for more variety
    hzScale = 1.25 + Random().nextDouble() * .5;
    hzOffset = -.2 + Random().nextDouble() * .4;

    //Create end points, these sit at yPos=0, and don't animate
    endPts.clear();
    //For n curves, we need n + 2 endpoints
    //Create first end point

    endPts.insert(
      0,
      Offset.zero,
    ); //Start at 0,0 NEEDED FOR QUAD. BEZIER CURVE...

    for (var i = 1; i < curveCount; i++) {
      endPts.add(Offset(gap * i * 2, 0));
    }
    //Last endpoint at 1,0
    endPts.add(const Offset(1, 0));

    // PERF TIP...
    ctrlPts.clear();

    // Always 4..
    for (var i = 0; i < curveCount; i++) {
      // Randomize this variable....
      final height = (.5 + Random().nextDouble() * .5) *
          (i % 2 == 0 ? 1 : -1) *
          (flipY ? -1 : 1);

      final animSequence = TweenSequence([
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

      // SEE BELOW HOW THE CTRL POINTS CHANGE>>>>
      ctrlPts.add(Offset(gap + gap * i * 2, height));
    }
  }

  List<Offset> _updateControlPointsFromTweens() {
    for (var i = 0; i < ctrlPts.length; i++) {
      final o = ctrlPts[i];

      ctrlPts[i] = Offset(o.dx, ctrlTweens[i].value);
    }

    // print('$ctrlPts');

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
      const Color(0xffC48D3B).withOpacity(.4),
    );
    _drawLiquidSim(
      simulation2,
      canvas,
      size,
      5,
      const Color(0xff9D7B32).withOpacity(.4),
    );
  }

  void _drawLiquidSim(
    LiquidSimulation simulation,
    Canvas canvas,
    Size size,
    double offsetY,
    Color color,
  ) {
    // canvas.scale(simulation.hzScale, 1);
    // canvas.translate(simulation.hzOffset * size.width, offsetY);

    // Create a path around bottom and sides of card >>>>> THIS ONLY FILLS THE CARD WITH WAVE...
    final path = Path()
      ..moveTo(size.width * 1.25, 0)
      ..lineTo(size.width * 1.25, size.height)
      ..lineTo(-size.width * .25, size.height)
      ..lineTo(-size.width * .25, 0);

    // // 4 times.
    // THIS LOOP MAKES the Waves like QBC...
    for (var i = 0; i < simulation.curveCount; i++) {
      final ctrlPt = sizeOffset(simulation.ctrlPts[i], size);
      final endPt = sizeOffset(simulation.endPts[i + 1], size);
      path.quadraticBezierTo(ctrlPt.dx, ctrlPt.dy, endPt.dx, endPt.dy);
    }

    canvas.drawPath(path, Paint()..color = color);

    // canvas.translate(-simulation.hzOffset * size.width, -offsetY);
    // canvas.scale(1 / simulation.hzScale, 1);
  }

  Offset sizeOffset(Offset pt, Size size) =>
      Offset(pt.dx * size.width, waveHeight * pt.dy);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/**
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.0), Offset(0.6, -0.1), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.0), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.2), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.2), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.2), Offset(0.4, 0.1), Offset(0.6, -0.2), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.2), Offset(0.4, -0.1), Offset(0.6, 0.2), Offset(0.9, -0.2)] 
flutter: >>>>> [Offset(0.1, -0.2), Offset(0.4, 0.1), Offset(0.6, -0.2), Offset(0.9, 0.2)] 
flutter: >>>>> [Offset(0.1, 0.2), Offset(0.4, -0.1), Offset(0.6, 0.2), Offset(0.9, -0.2)] 
flutter: >>>>> [Offset(0.1, -0.3), Offset(0.4, 0.2), Offset(0.6, -0.3), Offset(0.9, 0.2)] 
flutter: >>>>> [Offset(0.1, 0.3), Offset(0.4, -0.2), Offset(0.6, 0.3), Offset(0.9, -0.3)] 
flutter: >>>>> [Offset(0.1, -0.3), Offset(0.4, 0.2), Offset(0.6, -0.4), Offset(0.9, 0.3)] 
flutter: >>>>> [Offset(0.1, 0.4), Offset(0.4, -0.2), Offset(0.6, 0.3), Offset(0.9, -0.3)] 
flutter: >>>>> [Offset(0.1, -0.4), Offset(0.4, 0.3), Offset(0.6, -0.4), Offset(0.9, 0.3)] 
flutter: >>>>> [Offset(0.1, 0.4), Offset(0.4, -0.2), Offset(0.6, 0.3), Offset(0.9, -0.3)] 
flutter: >>>>> [Offset(0.1, -0.4), Offset(0.4, 0.3), Offset(0.6, -0.5), Offset(0.9, 0.3)] 
flutter: >>>>> [Offset(0.1, 0.5), Offset(0.4, -0.3), Offset(0.6, 0.4), Offset(0.9, -0.4)] 
flutter: >>>>> [Offset(0.1, -0.5), Offset(0.4, 0.3), Offset(0.6, -0.5), Offset(0.9, 0.4)] 
flutter: >>>>> [Offset(0.1, 0.5), Offset(0.4, -0.3), Offset(0.6, 0.4), Offset(0.9, -0.4)] 
flutter: >>>>> [Offset(0.1, -0.5), Offset(0.4, 0.3), Offset(0.6, -0.5), Offset(0.9, 0.4)] 
flutter: >>>>> [Offset(0.1, 0.5), Offset(0.4, -0.3), Offset(0.6, 0.4), Offset(0.9, -0.4)] 
flutter: >>>>> [Offset(0.1, -0.5), Offset(0.4, 0.4), Offset(0.6, -0.6), Offset(0.9, 0.4)] 
flutter: >>>>> [Offset(0.1, 0.6), Offset(0.4, -0.3), Offset(0.6, 0.5), Offset(0.9, -0.5)] 
flutter: >>>>> [Offset(0.1, -0.6), Offset(0.4, 0.4), Offset(0.6, -0.6), Offset(0.9, 0.5)] 
flutter: >>>>> [Offset(0.1, 0.6), Offset(0.4, -0.4), Offset(0.6, 0.5), Offset(0.9, -0.5)] 
flutter: >>>>> [Offset(0.1, -0.6), Offset(0.4, 0.4), Offset(0.6, -0.7), Offset(0.9, 0.5)] 
flutter: >>>>> [Offset(0.1, 0.7), Offset(0.4, -0.4), Offset(0.6, 0.5), Offset(0.9, -0.6)] 
flutter: >>>>> [Offset(0.1, -0.7), Offset(0.4, 0.4), Offset(0.6, -0.7), Offset(0.9, 0.5)] 
flutter: >>>>> [Offset(0.1, 0.7), Offset(0.4, -0.4), Offset(0.6, 0.6), Offset(0.9, -0.6)] 
flutter: >>>>> [Offset(0.1, -0.7), Offset(0.4, 0.5), Offset(0.6, -0.8), Offset(0.9, 0.6)] 
flutter: >>>>> [Offset(0.1, 0.8), Offset(0.4, -0.5), Offset(0.6, 0.6), Offset(0.9, -0.7)] 
flutter: >>>>> [Offset(0.1, -0.7), Offset(0.4, 0.5), Offset(0.6, -0.8), Offset(0.9, 0.6)] 
flutter: >>>>> [Offset(0.1, 0.7), Offset(0.4, -0.4), Offset(0.6, 0.6), Offset(0.9, -0.6)] 
flutter: >>>>> [Offset(0.1, -0.6), Offset(0.4, 0.4), Offset(0.6, -0.7), Offset(0.9, 0.5)] 
flutter: >>>>> [Offset(0.1, 0.6), Offset(0.4, -0.4), Offset(0.6, 0.5), Offset(0.9, -0.5)] 
flutter: >>>>> [Offset(0.1, -0.5), Offset(0.4, 0.3), Offset(0.6, -0.5), Offset(0.9, 0.4)] 
flutter: >>>>> [Offset(0.1, 0.5), Offset(0.4, -0.3), Offset(0.6, 0.4), Offset(0.9, -0.4)] 
flutter: >>>>> [Offset(0.1, -0.4), Offset(0.4, 0.3), Offset(0.6, -0.4), Offset(0.9, 0.3)] 
flutter: >>>>> [Offset(0.1, 0.4), Offset(0.4, -0.3), Offset(0.6, 0.3), Offset(0.9, -0.4)] 
flutter: >>>>> [Offset(0.1, -0.3), Offset(0.4, 0.2), Offset(0.6, -0.3), Offset(0.9, 0.2)] 
flutter: >>>>> [Offset(0.1, 0.3), Offset(0.4, -0.2), Offset(0.6, 0.3), Offset(0.9, -0.3)] 
flutter: >>>>> [Offset(0.1, -0.2), Offset(0.4, 0.1), Offset(0.6, -0.2), Offset(0.9, 0.2)] 
flutter: >>>>> [Offset(0.1, 0.2), Offset(0.4, -0.1), Offset(0.6, 0.2), Offset(0.9, -0.2)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.0), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.0), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.3), Offset(0.4, -0.2), Offset(0.6, 0.4), Offset(0.9, -0.3)] 
flutter: >>>>> [Offset(0.1, -0.4), Offset(0.4, 0.2), Offset(0.6, -0.3), Offset(0.9, 0.3)] 
flutter: >>>>> [Offset(0.1, 0.3), Offset(0.4, -0.2), Offset(0.6, 0.4), Offset(0.9, -0.3)] 
flutter: >>>>> [Offset(0.1, -0.3), Offset(0.4, 0.2), Offset(0.6, -0.3), Offset(0.9, 0.3)] 
flutter: >>>>> [Offset(0.1, 0.3), Offset(0.4, -0.2), Offset(0.6, 0.3), Offset(0.9, -0.2)] 
flutter: >>>>> [Offset(0.1, -0.3), Offset(0.4, 0.2), Offset(0.6, -0.2), Offset(0.9, 0.2)] 
flutter: >>>>> [Offset(0.1, 0.3), Offset(0.4, -0.2), Offset(0.6, 0.3), Offset(0.9, -0.2)] 
flutter: >>>>> [Offset(0.1, -0.3), Offset(0.4, 0.2), Offset(0.6, -0.2), Offset(0.9, 0.2)] 
flutter: >>>>> [Offset(0.1, 0.2), Offset(0.4, -0.1), Offset(0.6, 0.2), Offset(0.9, -0.2)] 
flutter: >>>>> [Offset(0.1, -0.2), Offset(0.4, 0.1), Offset(0.6, -0.2), Offset(0.9, 0.2)] 
flutter: >>>>> [Offset(0.1, 0.2), Offset(0.4, -0.1), Offset(0.6, 0.2), Offset(0.9, -0.2)] 
flutter: >>>>> [Offset(0.1, -0.2), Offset(0.4, 0.1), Offset(0.6, -0.2), Offset(0.9, 0.2)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.0), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.0), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.0), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.1), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.1), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.0), Offset(0.6, -0.1), Offset(0.9, 0.1)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.0), Offset(0.6, 0.1), Offset(0.9, -0.1)] 
flutter: >>>>> [Offset(0.1, -0.1), Offset(0.4, 0.0), Offset(0.6, -0.1), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.1), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, -0.0), Offset(0.4, 0.0), Offset(0.6, -0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, -0.0), Offset(0.6, 0.0), Offset(0.9, -0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)] 
flutter: >>>>> [Offset(0.1, 0.0), Offset(0.4, 0.0), Offset(0.6, 0.0), Offset(0.9, 0.0)]
 */
