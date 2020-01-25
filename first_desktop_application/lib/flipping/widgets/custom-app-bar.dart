import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const CustomAppBar({
    Key key,
    @required this.height,
    @required this.appBarIconsColor,
  }) : super(key: key);

  final Color appBarIconsColor;

  @override
  Widget build(BuildContext context) {
    //

    return AppBar(
      leading: GestureDetector(
        child: Icon(Icons.arrow_back, color: appBarIconsColor),
        onTap: () => Navigator.pop(context),
      ),
      brightness: Brightness.light,
      backgroundColor: Color(0xFFf0f0f0),
      elevation: 0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Boarding Passes'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            letterSpacing: 0.5,
            color: appBarIconsColor,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
