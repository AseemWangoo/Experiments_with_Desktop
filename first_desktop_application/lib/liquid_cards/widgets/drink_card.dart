import 'dart:math';

import 'package:first_desktop_application/liquid_cards/data/demo_data.dart';
import 'package:first_desktop_application/liquid_cards/styles/styles.dart';
import 'package:first_desktop_application/liquid_cards/widgets/liquid_painter.dart';
import 'package:first_desktop_application/liquid_cards/widgets/rounded_shadow.dart';
import 'package:flutter/material.dart';

class DrinkListCard extends StatefulWidget {
  static double nominalHeightClosed = 96;
  static double nominalHeightOpen = 290;

  final Function(DrinkData) onTap;

  final bool isOpen;
  final DrinkData drinkData;
  final int earnedPoints;

  const DrinkListCard({
    Key key,
    this.onTap,
    this.isOpen,
    this.drinkData,
    this.earnedPoints,
  }) : super(key: key);

  @override
  _DrinkListCardState createState() => _DrinkListCardState();
}

class _DrinkListCardState extends State<DrinkListCard>
    with SingleTickerProviderStateMixin {
  bool _wasOpen;
  Animation<double> _fillTween;
  Animation<double> _pointsTween;

  AnimationController _liquidSimController;

  final LiquidSimulation _liquidSim1 = LiquidSimulation();
  final LiquidSimulation _liquidSim2 = LiquidSimulation();

  @override
  void initState() {
    super.initState();
    _liquidSimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _liquidSimController.addListener(_rebuildIfOpen);

    // Raises the fill level of the card
    _fillTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _liquidSimController,
        curve: const Interval(.12, .45, curve: Curves.easeOut),
      ),
    );

    // Tween to animate the 'points remaining' text
    _pointsTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _liquidSimController,
        curve: const Interval(.1, .5, curve: Curves.easeOutQuart),
      ),
    );
  }

  @override
  void dispose() {
    _liquidSimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the points required text value, using the _pointsTween
    // THIS DECREASES THE POINTS...
    final pointsRequired = widget.drinkData.requiredPoints;
    final pointsValue = pointsRequired -
        _pointsTween.value * min(widget.earnedPoints, pointsRequired);

    // print('>>> $pointsValue');

    // print('IS OPEN >>>> ${widget.isOpen}');
    if (widget.isOpen != _wasOpen) {
      // SHOW ANIMS ONLY IF CARD IS OPEN..
      if (widget.isOpen) {
        _liquidSim1.start(_liquidSimController, true);
        _liquidSim2.start(_liquidSimController, false);

        _liquidSimController.forward(from: 0);

        // print('INSIDE INNNER IF');
      }
      // print('OUTSIDE IF');

      _wasOpen = widget.isOpen; // EITHER FALSE OR TRUE....
    }

    // print('WAS OPEN >>>> $_wasOpen');

    /// widget.earnedPoints -> always same 150.0
    /// Value is taken min. b/w 1 and the division...(as animation max value is 1.0)
    final double _maxFillLevel = min(
      1,
      widget.earnedPoints / widget.drinkData.requiredPoints,
    );

    final double fillLevel = _maxFillLevel;

    final double cardHeight = widget.isOpen
        ? DrinkListCard.nominalHeightOpen
        : DrinkListCard.nominalHeightClosed;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        curve: !_wasOpen ? const ElasticOutCurve(.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !_wasOpen ? 1200 : 1500),
        height: cardHeight,
        child: RoundedShadow.fromRadius(
          12.0,
          child: Container(
            color: const Color(0xff303238),
            child: Stack(
              children: <Widget>[
                // RESPONSIBLE FOR OPACITY FOR THE WAVES..
                AnimatedOpacity(
                  opacity: widget.isOpen ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: _buildLiquidBackground(_maxFillLevel, fillLevel),
                ),

                //Card Content
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 24),
                        _buildTopContent(),
                        //Spacer
                        const SizedBox(height: 12.0),

                        /// Wrap this with A.O
                        /// If dont wrap, then you see the text there..
                        AnimatedOpacity(
                          duration: Duration(
                            milliseconds: widget.isOpen ? 1000 : 500,
                          ),
                          curve: Curves.easeOut,
                          opacity: widget.isOpen ? 1 : 0,
                          child: _buildBottomContent(pointsValue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack _buildLiquidBackground(double _maxFillLevel, double fillLevel) {
    // RESPONSIBLE FOR MAKING THE WAVE FROM BOTTOM TO UP...
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.translate(
          offset: Offset(
            0,
            DrinkListCard.nominalHeightOpen * 1.2 -
                DrinkListCard.nominalHeightOpen *
                    _fillTween.value *
                    _maxFillLevel *
                    1.2,
          ),
          child: CustomPaint(
            painter: LiquidPainter(
              fillLevel,
              _liquidSim1,
              _liquidSim2,
              waveHeight: 100,
            ),
          ),
        ),
      ],
    );
  }

  Row _buildTopContent() {
    return Row(
      children: <Widget>[
        //Icon
        Image.asset(
          "assets/images/${widget.drinkData.iconImage}",
          fit: BoxFit.fitWidth,
          width: 50.0,
        ),
        const SizedBox(width: 24),
        //Label
        Expanded(
          child: Text(
            widget.drinkData.title.toUpperCase(),
            style: Styles.text(18, Colors.white, true),
          ),
        ),
        //Star Icon
        Icon(Icons.star, size: 20, color: AppColors.orangeAccent),
        const SizedBox(width: 4),
        //Points Text
        Text(
          "${widget.drinkData.requiredPoints}",
          style: Styles.text(20, Colors.white, true),
        )
      ],
    );
  }

  Column _buildBottomContent(double pointsValue) {
    final List<Widget> rowChildren = [];

    if (pointsValue == 0) {
      rowChildren.add(
        Text("Congratulations!", style: Styles.text(16, Colors.white, true)),
      );
    } else {
      rowChildren.addAll([
        Text("You're only ", style: Styles.text(12, Colors.white, false)),
        Text(
          " ${pointsValue.round()} ",
          style: Styles.text(16, AppColors.orangeAccent, true),
        ),
        Text(
          " points away",
          style: Styles.text(12, Colors.white, false),
        ),
      ]);
    }

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
        const SizedBox(height: 16),
        Text(
          "Redeem your points for a cup of happiness! Our signature espresso is blanced with steamed milk and topped with a light layer of foam. ",
          textAlign: TextAlign.center,
          style: Styles.text(14, Colors.white, false, height: 1.5),
        ),
        const SizedBox(height: 16.0),
        //Main Button
        //Main Button
        ButtonTheme(
          minWidth: 200,
          height: 40,
          child: FlatButton(
            onPressed: () {},
            color: AppColors.orangeAccent,
            disabledColor: AppColors.orangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text("REDEEM", style: Styles.text(16, Colors.white, true)),
          ),
        )
      ],
    );
  }

  /// Override the handle tap...
  /// Pass the drinkData back to the callee.
  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap(widget.drinkData);
    }
  }

  void _rebuildIfOpen() {
    if (widget.isOpen) {
      setState(() {});
    }
  }
}
