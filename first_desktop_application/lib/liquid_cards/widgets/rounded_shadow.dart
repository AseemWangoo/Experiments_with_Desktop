import 'dart:math';

import 'package:flutter/material.dart';

class RoundedShadow extends StatelessWidget {
  final Widget child;
  final Color shadowColor;

  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;

  const RoundedShadow({
    Key key,
    this.child,
    this.shadowColor,
    this.topLeftRadius = 48,
    this.topRightRadius = 48,
    this.bottomLeftRadius = 48,
    this.bottomRightRadius = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create a border radius, only applies to the bottom
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(topLeftRadius),
      topRight: Radius.circular(topRightRadius),
      bottomLeft: Radius.circular(bottomLeftRadius),
      bottomRight: Radius.circular(bottomRightRadius),
    );

    Color sColor = shadowColor ?? Color(0x20000000);

    double maxRadius = [
      topLeftRadius,
      topRightRadius,
      bottomLeftRadius,
      bottomRightRadius
    ].reduce(max);

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(color: sColor, blurRadius: maxRadius * .5),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
