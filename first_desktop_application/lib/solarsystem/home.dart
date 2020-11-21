import 'package:first_desktop_application/app-level/utils/screen_size.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

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
      duration: const Duration(seconds: 50),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Offset _offset = Offset(0.3, -0.9);
    timeDilation = 2.0;

    final _height = ScreenQueries.instance.height(context);
    final _width = ScreenQueries.instance.width(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF050303),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: const Text('Back'),
        icon: const Icon(Icons.arrow_back),
        backgroundColor: Colors.black,
      ),
    );
  }
}
