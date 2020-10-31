import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// class OptionButton extends StatefulWidget {
//   const OptionButton({
//     Key key,
//     @required this.buttonText,
//     @required this.onTap,
//   }) : super(key: key);

//   ///Specify the button text...
//   final String buttonText;

//   ///Action on tap of the button....
//   final VoidCallback onTap;

//   @override
//   _OptionButtonState createState() => _OptionButtonState();
// }

// class _OptionButtonState extends State<OptionButton>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       padding: const EdgeInsets.all(8.0),
//       textColor: Colors.white,
//       color: Colors.blue,
//       onPressed: widget.onTap,
//       child: Text(widget.buttonText),
//     );
//   }
// }

class OptionButton extends StatefulWidget {
  const OptionButton({
    Key key,
    @required this.buttonText,
    @required this.onTap,
  }) : super(key: key);

  ///Specify the button text...
  final String buttonText;

  ///Action on tap of the button....
  final VoidCallback onTap;

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with TickerProviderStateMixin {
  AnimationController _animControlPlanet, _animControlSatellite;

  Animation<double> _rotateAnimPlanet, _rotateAnimSatellite;

  @override
  void initState() {
    super.initState();
    _animControlPlanet = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );

    _rotateAnimPlanet = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animControlPlanet, curve: const Interval(0.0, 1.0)),
    );

    _rotateAnimPlanet.addListener(() {
      setState(() {});
    });

    _animControlSatellite = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _rotateAnimSatellite = Tween(begin: 0.0, end: 1.0).animate(
      _animControlSatellite,
    );

    _animControlPlanet.forward();
    _animControlSatellite.forward();
  }

  @override
  void dispose() {
    _animControlPlanet.dispose();
    _animControlSatellite.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    timeDilation = 2.0;

    return Container(
      margin: const EdgeInsets.all(15.0),
      child: CustomPaint(
        foregroundPainter: RadialSeekBarPainter(
          trackWidth: 3.0,
          trackColor: Colors.orange,
          progressWidth: 0.0,
          progressColor: Colors.transparent,
          progressPercent: 0.8,
          thumbSize: 15.0,
          thumbColor: Colors.cyan,
          thumbPosition: _rotateAnimSatellite.value,
        ),
        child: RotationTransition(
          turns: _animControlPlanet,
          // child: RaisedButton(
          //   padding: const EdgeInsets.all(8.0),
          //   textColor: Colors.white,
          //   color: Colors.blue,
          //   onPressed: widget.onTap,
          //   child: Text(widget.buttonText),
          // ),
          // child: Container(
          //   height: 100.0,
          //   width: 100.0,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.rectangle,
          //     color: Colors.grey[850],
          //   ),
          // ),
          child: RawMaterialButton(
            onPressed: () {},
            shape: const CircleBorder(),
            fillColor: Colors.white,
            padding: const EdgeInsets.all(15.0),
            child: Text(widget.buttonText),
          ),
        ),
      ),
    );
  }
}

class RadialSeekBarPainter extends CustomPainter {
  final double trackWidth;
  final Paint trackPaint;
  final double progressWidth;
  final Paint progressPaint;
  final double progressPercent;
  final double thumbSize;
  final Paint thumbPaint;
  final double thumbPosition;

  RadialSeekBarPainter({
    @required this.trackWidth,
    @required Color trackColor,
    @required this.progressWidth,
    @required Color progressColor,
    @required this.progressPercent,
    @required this.thumbSize,
    @required Color thumbColor,
    @required this.thumbPosition,
  })  : trackPaint = Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = trackWidth,
        progressPaint = Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = progressWidth
          ..strokeCap = StrokeCap.round,
        thumbPaint = Paint()
          ..color = thumbColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final outerThickness = max(trackWidth, max(progressWidth, thumbSize));
    final Size constrainedSize = Size(
      size.width - outerThickness,
      size.height - outerThickness,
    );

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(constrainedSize.width, constrainedSize.height) / 2;

    // Paint track.
    canvas.drawCircle(
      center,
      radius,
      trackPaint,
    );

    // Paint progress.
    final progressAngle = 2 * pi * progressPercent;
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );

    // Paint thumb.
    final thumbAngle = 2 * pi * thumbPosition - (pi / 2);
    final thumbX = cos(thumbAngle) * radius;
    final thumbY = sin(thumbAngle) * radius;
    final thumbCenter = Offset(thumbX, thumbY) + center;
    final thumbRadius = thumbSize / 2.0;
    canvas.drawCircle(
      thumbCenter,
      thumbRadius,
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
