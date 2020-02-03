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

class _TransitionContainerState extends State<TransitionContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final width = appSize.width;
    final height = appSize.height;

    List<Widget> children = <Widget>[
      Container(
        width: width,
        height: height,
        child: widget.child,
      ),
    ];

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
    super.dispose();
  }
}
