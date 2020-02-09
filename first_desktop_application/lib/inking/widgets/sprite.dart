import 'package:flutter/material.dart';

class Sprite extends StatefulWidget {
  final ImageProvider image;
  final double frameWidth;

  final double frameHeight;
  final num frame;

  Sprite({
    Key key,
    @required this.image,
    @required this.frameWidth,
    this.frameHeight,
    this.frame = 0,
  }) : super(key: key);

  @override
  _SpriteState createState() => _SpriteState();
}

class _SpriteState extends State<Sprite> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
