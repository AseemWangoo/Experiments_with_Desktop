import 'package:first_desktop_application/inking/widgets/animated_sprite.dart';
import 'package:first_desktop_application/inking/widgets/widget_mask.dart';
import 'package:flutter/material.dart';

class TransitionContainer extends StatefulWidget {
  final Widget child;

  final bool darkModeValue;

  TransitionContainer({
    Key key,
    this.child,
    this.darkModeValue,
  }) : super(key: key);

  @override
  _TransitionContainerState createState() => _TransitionContainerState();
}

class _TransitionContainerState extends State<TransitionContainer>
    with SingleTickerProviderStateMixin {
  //

  AnimationController _controller;
  Animation<double> _animation;

  List<ImageProvider> _images;
  int _currentImageIndex = 0;

  Widget _childForeground;
  Widget _childBackground;

  @override
  void initState() {
    _images = [
      AssetImage('assets/images/ink_mask.png'),
      AssetImage('assets/images/wipe_mask.png'),
      AssetImage('assets/images/tendril_mask.png'),
    ];

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _childBackground = _childForeground;
          _childForeground = null;
        });
        _controller.reset();
      }
    });

    _animation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 0.0),
          weight: 30,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 34.0),
          weight: 70,
        ),
      ],
    ).animate(_controller);

    super.initState();
  }

  @override
  void didUpdateWidget(TransitionContainer oldWidget) {
    _handleDarkModeChange();
    if (widget.child != oldWidget.child) {
      setState(() => _childForeground = widget.child);
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final width = appSize.width;
    final height = appSize.height;

    // print('>>>> FG ${_childForeground.runtimeType}');
    // print('>>>> BG ${_childBackground.runtimeType}');

    // 0 => light mode
    // Clicked on first time, then index goes to 1 (dark Mode)...
    // Clicked again, index = 1 (light mode)..
    // CLicked on dark mode, index = 2 (2 >=3)
    // print('>>>> Image ${_images[_currentImageIndex]} >>> $_currentImageIndex');

    List<Widget> children = <Widget>[
      Container(
        width: width,
        height: height,
        child: _childBackground ?? widget.child, // Changed line....
      ),
    ];

    if (_childForeground != null) {
      children.add(
        WidgetMask(
          child: Container(
            width: width,
            height: height,
            child: _childForeground,
          ),
          // Wrapping with Container VVIP..
          maskChild: Container(
            width: width,
            height: height,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return AnimatedSprite(
                  image: _images[_currentImageIndex],
                  frameWidth: 360, // Works well with this number
                  frameHeight: 720, // Works well with this number
                  animation: _animation,
                );
              },
            ),
          ),
        ),
      );
    }

    return Positioned(
      left: 0,
      width: width,
      height: height,
      child: Stack(
        children: children,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleDarkModeChange() {
    if (widget.darkModeValue) {
      setState(() {
        ++_currentImageIndex;
        if (_currentImageIndex >= _images.length) {
          _currentImageIndex = 0;
        }
      });
    }
  }
}

/*

When clicked on mode change first
flutter: >>>> BG Null
flutter: >>>> FG DarkInkContent

At the end of animation....
flutter: >>>> FG Null
flutter: >>>> BG DarkInkContent
 */
