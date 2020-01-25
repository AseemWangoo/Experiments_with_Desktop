import 'dart:math';

import 'package:flutter/material.dart';

class FoldingTicket extends StatefulWidget {
  static const double padding = 16.0;
  final bool isOpen;
  final Duration duration;

  FoldingTicket({this.duration, this.isOpen = false});

  @override
  _FoldingTicketState createState() => _FoldingTicketState();
}

class _FoldingTicketState extends State<FoldingTicket>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _ratio = 0.0;

  bool get isOpen => widget.isOpen;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(FoldingTicket.padding),
      // height: closedHeight +
      //     (openHeight - closedHeight) * Curves.easeOut.transform(_ratio),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 10,
                spreadRadius: 1)
          ],
        ),
        child: _buildEntry(0),
      ),
    );
  }

  Widget _buildEntry(int index, [double offset = 0.0]) {
    Matrix4 mtx = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..setEntry(1, 2, 0.2)
      ..translate(0.0, offset)
      ..rotateX(pi);

    return Transform(
      alignment: Alignment.topCenter,
      transform: mtx,
      child: Container(
        child: Text('Hello'),
      ),
    );
  }
}
