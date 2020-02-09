import 'package:first_desktop_application/inking/widgets/sprite.dart';
import 'package:flutter/material.dart';

class AnimatedSprite extends AnimatedWidget {
  final double frameWidth;
  final double frameHeight;
  final ImageProvider image;

  AnimatedSprite({
    Key key,
    @required this.image,
    @required Animation<double> animation,
    @required this.frameWidth,
    this.frameHeight,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return Sprite(
      image: image,
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      frame: animation.value,
    );
  }
}
