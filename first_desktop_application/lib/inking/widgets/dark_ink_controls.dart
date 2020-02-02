import 'package:flutter/material.dart';

class DarkInkControls extends StatefulWidget {
  final bool darkModeValue;

  const DarkInkControls({
    Key key,
    this.darkModeValue,
  }) : super(key: key);

  @override
  _DarkInkControlsState createState() => _DarkInkControlsState();
}

class _DarkInkControlsState extends State<DarkInkControls>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _buttonAnimation0;
  Animation<double> _buttonAnimation1;
  Animation<double> _buttonAnimation2;

  Color _backgroundColor;
  Color _foregroundColor;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _buttonAnimation0 = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 100.0),
          weight: 10,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(100.0),
          weight: 76,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 100.0, end: 0.0),
          weight: 10,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.0),
          weight: 4,
        ),
      ],
    ).animate(_controller);

    _buttonAnimation1 = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 0.0),
          weight: 2,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 100.0),
          weight: 10,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(100.0),
          weight: 76,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 100.0, end: 0.0),
          weight: 10,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(0.0),
          weight: 2,
        ),
      ],
    ).animate(_controller);

    _buttonAnimation2 = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 0.0),
          weight: 4,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 100.0),
          weight: 10,
        ),
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(100.0),
          weight: 76,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 100.0, end: 0.0),
          weight: 10,
        ),
      ],
    ).animate(_controller);

    super.initState();
  }

  @override
  void didUpdateWidget(DarkInkControls oldWidget) {
    _handleDarkModeChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;

    _updateColor();

    return Positioned(
      left: 0,
      top: appSize.height - 80,
      width: appSize.width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _buttonAnimation0,
            builder: (context, child) {
              //

              return Transform(
                transform:
                    Matrix4.translationValues(0, _buttonAnimation0.value, 0),
                child: child,
              );
            },
            child: FloatingActionButton(
              mini: true,
              heroTag: 0,
              onPressed: () => {},
              backgroundColor: _backgroundColor,
              foregroundColor: _foregroundColor,
              child: Icon(Icons.bookmark_border),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          AnimatedBuilder(
            animation: _buttonAnimation1,
            builder: (context, child) {
              //

              return Transform(
                transform:
                    Matrix4.translationValues(0, _buttonAnimation1.value, 0),
                child: child,
              );
            },
            child: FloatingActionButton(
              mini: true,
              heroTag: 1,
              onPressed: () => {},
              backgroundColor: _backgroundColor,
              foregroundColor: _foregroundColor,
              child: Icon(Icons.more_horiz),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          AnimatedBuilder(
            animation: _buttonAnimation2,
            builder: (context, child) {
              //

              return Transform(
                transform:
                    Matrix4.translationValues(0, _buttonAnimation2.value, 0),
                child: child,
              );
            },
            child: FloatingActionButton(
              heroTag: 2,
              mini: true,
              onPressed: () => {},
              backgroundColor: _backgroundColor,
              foregroundColor: _foregroundColor,
              child: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // OTHER FXNS
  void _updateColor() {
    final darkColor = Color(0xFF171137);
    final lightColor = Color(0xFF67ECDC);
    _backgroundColor = widget.darkModeValue ? darkColor : lightColor;
    _foregroundColor = widget.darkModeValue ? lightColor : darkColor;
  }

  void _handleDarkModeChange() {
    _controller.forward(from: 0.0);
  }
}
