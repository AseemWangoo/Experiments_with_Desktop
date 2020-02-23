import 'package:flutter/material.dart';

class LiquidSimulation {
  List<Offset> ctrlPts = [];
  List<Animation<double>> ctrlTweens = [];

  // Y beause we animating the y-axis...
  void start(AnimationController controller, bool flipY) {
    controller.addListener(_updateControlPointsFromTweens);
  }

  List<Offset> _updateControlPointsFromTweens() {
    for (var i = 0; i < ctrlPts.length; i++) {
      var o = ctrlPts[i];

      ctrlPts[i] = Offset(o.dx, ctrlTweens[i].value);
    }

    print('>>>>> ${ctrlPts}');
    return ctrlPts;
  }
}

class LiquidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
