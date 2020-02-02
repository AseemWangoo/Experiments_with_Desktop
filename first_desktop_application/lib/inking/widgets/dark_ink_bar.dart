import 'package:first_desktop_application/inking/models/dark_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkInkBar extends StatefulWidget {
  final bool darkModeValue;

  const DarkInkBar({Key key, this.darkModeValue = false}) : super(key: key);

  @override
  _DarkInkBarState createState() => _DarkInkBarState();
}

class _DarkInkBarState extends State<DarkInkBar>
    with SingleTickerProviderStateMixin {
  static final Color darkColor = Color(0xFF171137);
  static final Color lightColor = Color(0xFF67ECDC);

  AnimationController _controller;
  Animation<double> _iconOpacityAnimation;
  Animation<double> _backgroundColorAnimation;
  Animation<double> _foregroundColorAnimation;

  ImageProvider _darkModeToggleIconImage;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _iconOpacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: .20,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(0.0),
        weight: .20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: .20,
      ),
    ]).animate(_controller);

    _backgroundColorAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 0.0),
          weight: .20,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: .1,
        ),
        TweenSequenceItem(
          tween: ConstantTween<double>(1.0),
          weight: .20,
        ),
      ],
    ).animate(_controller);

    _foregroundColorAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 1.0),
          weight: .35,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.0),
          weight: .1,
        ),
        TweenSequenceItem(
          tween: ConstantTween<double>(0.0),
          weight: .55,
        ),
      ],
    ).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    final appSize = MediaQuery.of(context).size;
    final _model = Provider.of<TransitionModel>(context);

    final backgroundColor = HSVColor.lerp(
      HSVColor.fromColor(lightColor),
      HSVColor.fromColor(darkColor),
      _backgroundColorAnimation.value,
    ).toColor();

    final foregroundColor = HSVColor.lerp(
      HSVColor.fromColor(lightColor),
      HSVColor.fromColor(darkColor),
      _foregroundColorAnimation.value,
    ).toColor();

    return Positioned(
      left: 0,
      top: 0,
      width: appSize.width,
      child: Column(
        children: [
          Container(
            color: backgroundColor,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    textColor: foregroundColor,
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  FlatButton(
                    onPressed: () => {},
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    textColor: foregroundColor,
                    child: ImageIcon(AssetImage(
                      'assets/images/icon-r.png',
                    )),
                  ),
                  FlatButton(
                    onPressed: () {
                      _model.switchMode(!_model.currentMode);
                      _handleDarkModeChange();
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    textColor: foregroundColor,
                    child: AnimatedBuilder(
                      animation: _iconOpacityAnimation,
                      builder: (context, child) {
                        // SOLVING FIRST LOAD ISSUE...
                        if (_model.isFirstLoad) {
                          _darkModeToggleIconImage =
                              AssetImage('assets/images/icon-moon.png');
                        } else {
                          _darkModeToggleIconImage = _updateIcon();
                        }

                        return Opacity(
                          opacity: _iconOpacityAnimation.value,
                          child: ImageIcon(_darkModeToggleIconImage),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 2,
            color: widget.darkModeValue ? Color(0xFF0098A3) : Color(0xFF2B777E),
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

  // OTHER FXNS....
  ImageProvider<dynamic> _updateIcon() {
    if (_controller.value < 0.5) {
      return _darkModeToggleIconImage =
          AssetImage('assets/images/icon-sun.png');
    } else {
      return _darkModeToggleIconImage =
          AssetImage('assets/images/icon-moon.png');
    }
  }

  void _handleDarkModeChange() {
    if (widget.darkModeValue) {
      _controller.forward(from: 0.0);
    } else {
      _controller.reverse(from: 1.0);
    }
  }
}
