import 'package:first_desktop_application/liquid_cards/data/demo_data.dart';
import 'package:flutter/material.dart';

class DrinkListCard extends StatefulWidget {
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
  AnimationController _liquidSimController;

  @override
  void initState() {
    super.initState();
    _liquidSimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
  }

  @override
  void dispose() {
    _liquidSimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        color: Color(0xff303238),
        child: Stack(
          children: <Widget>[
            //Card Content
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    //TODO:
  }
}
