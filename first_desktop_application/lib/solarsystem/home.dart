import 'package:first_desktop_application/app-level/utils/screen_size.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 50),
      vsync: this,
    );

    _controller.forward().orCancel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Offset _offset = Offset(0.3, -0.9);
    // timeDilation = 2.0;

    final _height = ScreenQueries.instance.height(context);
    final _width = ScreenQueries.instance.width(context);

    return Scaffold(
      appBar: AppBar(),
      // backgroundColor: Colors.black,
      body: Center(
        child: Transform(
          alignment: FractionalOffset.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0011)
            ..rotateX(_offset.dy)
            ..rotateY(_offset.dx),
          child: RotationTransition(
            turns: _controller,
            child: Image.asset(
              'assets/images/galaxy.jpg',
              fit: BoxFit.contain,
              height: _height,
              width: _width,
            ),
          ),
        ),
      ),
    );
  }
}
