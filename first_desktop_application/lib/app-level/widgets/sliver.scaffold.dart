import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class SimpleSliverScaffold extends StatelessWidget {
  const SimpleSliverScaffold({
    Key key,
    @required List<Widget> children,
    @required Widget menu,
    this.minHeight = 56.0,
    this.maxHeight = 56.0,
    this.controller,
  })  : _children = children,
        _menu = menu,
        super(key: key);

  final List<Widget> _children;
  final Widget _menu;
  final double minHeight;
  final double maxHeight;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    //

    return CustomScrollView(
      controller: controller,
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: _SliverDelegate(
            child: _menu,
            minHeight: minHeight,
            maxHeight: maxHeight,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, int index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [..._children],
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

// **************************** INTERNALS ****************************
class _SliverDelegate implements SliverPersistentHeaderDelegate {
  _SliverDelegate({
    this.minHeight = 56.0,
    this.maxHeight = 56.0,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        elevation: 4.0,
        child: SizedBox.expand(child: child),
      ),
    );
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      const PersistentHeaderShowOnScreenConfiguration();

  @override
  TickerProvider get vsync => null;
}
