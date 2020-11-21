import 'dart:math';

import 'package:flutter/material.dart';

class FoldingTicket extends StatefulWidget {
  static const double padding = 16.0;
  final bool isOpen;
  final List<FoldEntry> entries;
  final Duration duration;

  const FoldingTicket(
      {this.duration, @required this.entries, this.isOpen = false});

  @override
  _FoldingTicketState createState() => _FoldingTicketState();
}

class _FoldingTicketState extends State<FoldingTicket>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _ratio = 0.0;
  List<FoldEntry> _entries;

  double get openHeight =>
      _entries.fold<double>(0.0, (val, o) => val + o.height) +
      FoldingTicket.padding * 2;

  double get closedHeight => _entries[0].height + FoldingTicket.padding * 2;

  bool get isOpen => widget.isOpen;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_tick);
    _updateFromWidget();
  }

  @override
  void didUpdateWidget(FoldingTicket oldWidget) {
    // IMPORTANT STEP..
    isOpen ? _controller.forward() : _controller.reverse();
    _updateFromWidget();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(FoldingTicket.padding),
      // Shifts the height..
      height: closedHeight +
          (openHeight - closedHeight) * Curves.easeOut.transform(_ratio),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: _buildEntry(0),
      ),
    );
  }

  Widget _buildEntry(int index, [double offset = 0.0]) {
    // Fxn to handle the folding...
    final int count = _entries.length - 1;
    final FoldEntry entry = _entries[index];
    final double ratio = max(0.0, min(1.0, _ratio * count + 1.0 - index * 1.0));

    // Intelligently playing with recursion..
    final Matrix4 mtx = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..setEntry(1, 2, 0.2)
      ..translate(0.0, offset)
      ..rotateX(pi * (ratio - 1.0));

    // If one child, no need for stack...
    final Widget card = SizedBox(
        height: entry.height, child: ratio < 0.5 ? entry.back : entry.front);

    return Transform(
      alignment: Alignment.topCenter,
      transform: mtx,
      child: Container(
        child: (index == count || ratio <= 0.5)
            ? card
            : Stack(
                children: [
                  card,
                  _buildEntry(index + 1, entry.height),
                ],
              ),
      ),
    );
  }

  void _updateFromWidget() {
    _entries = widget.entries;
    // Sets default duration to anim controller...
    _controller.duration =
        widget.duration ?? Duration(milliseconds: 400 * (_entries.length - 1));
  }

  void _tick() {
    // Sets the ratio for future calculations...
    setState(() {
      _ratio = Curves.easeInQuad.transform(_controller.value);
    });
  }
}

class FoldEntry {
  final Widget front;
  Widget back;
  final double height;

  // Back card transformation..

  FoldEntry({@required this.front, @required this.height, Widget back}) {
    this.back = Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, .001)
        ..rotateX(pi),
      child: back,
    );
  }
}
