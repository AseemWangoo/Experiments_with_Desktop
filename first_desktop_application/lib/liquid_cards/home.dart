import 'package:first_desktop_application/liquid_cards/data/demo_data.dart';
import 'package:first_desktop_application/liquid_cards/styles/styles.dart';
import 'package:first_desktop_application/liquid_cards/widgets/drink_card.dart';
import 'package:first_desktop_application/liquid_cards/widgets/rounded_shadow.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _listPadding = 20;
  DrinkData _selectedDrink;
  final ScrollController _scrollController = ScrollController();
  List<DrinkData> _drinks;
  int _earnedPoints;

  @override
  void initState() {
    final demoData = DemoData();
    _drinks = demoData.drinks;
    _earnedPoints = demoData.earnedPoints;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    final bool isLandscape = MediaQuery.of(context).size.aspectRatio > 1;
    final double headerHeight =
        MediaQuery.of(context).size.height * (isLandscape ? .25 : .2);

    return Scaffold(
      appBar: AppBar(title: const Text('Liquid Cards')),
      backgroundColor: const Color(0xff22222b),
      body: Theme(
        data: ThemeData(fontFamily: "Poppins", primarySwatch: Colors.orange),
        child: Stack(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.only(bottom: 40, top: headerHeight + 10),
              itemCount: _drinks.length,
              controller: _scrollController,
              itemBuilder: (context, index) => _buildListItem(index),
            ),
            _buildTopBg(headerHeight),
            _buildTopContent(headerHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBg(double height) {
    return Container(
      alignment: Alignment.topCenter,
      height: height,
      child: RoundedShadow(
        topLeftRadius: 0,
        topRightRadius: 0,
        shadowColor: const Color(0x00000000).withAlpha(65),
        child: SizedBox(
          width: double.infinity,
          child: Image.asset(
            "assets/images/Header-Dark.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildTopContent(double height) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        height: height,
        padding: EdgeInsets.all(height * .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "My Rewards",
              style: Styles.text(height * .13, Colors.white, true),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star, color: AppColors.redAccent, size: height * .2),
                const SizedBox(width: 8),
                Text(
                  "$_earnedPoints",
                  style: Styles.text(height * .3, Colors.white, true),
                ),
              ],
            ),
            Text(
              "Your Points Balance",
              style: Styles.text(height * .1, Colors.white, false),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: _listPadding / 2,
        horizontal: _listPadding,
      ),
      child: DrinkListCard(
        earnedPoints: _earnedPoints,
        drinkData: _drinks[index],
        isOpen: _drinks[index] == _selectedDrink,
        onTap: _handleDrinkTapped,
      ),
      // SETS ONLY THE SELECTED DRINK TO TRUE....
    );
  }

  void _handleDrinkTapped(DrinkData data) {
    //Open tapped drink card and scroll to it

    // UNSELECT THE CARD, IF SAME CLICKED TWICE...
    setState(() {
      if (_selectedDrink == data) {
        _selectedDrink = null;
      } else {
        _selectedDrink = data;
        final int selectedIndex = _drinks.indexOf(_selectedDrink);

        final double closedHeight = DrinkListCard.nominalHeightClosed;

        // ADJUST SCROLLER >>>>
        final offset =
            selectedIndex * (closedHeight + _listPadding) - closedHeight * .35;

        // print('Offset >> $offset');

        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutQuad,
        );
      }
    });
  }
}
