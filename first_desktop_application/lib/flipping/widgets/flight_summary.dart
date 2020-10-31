import 'package:first_desktop_application/flipping/data/demo_data.dart';
import 'package:flutter/material.dart';

enum SummaryTheme { dark, light }

class FlightSummary extends StatelessWidget {
  final BoardingPassData boardingPass;
  final SummaryTheme theme;
  final bool isOpen;

  const FlightSummary({
    Key key,
    this.boardingPass,
    this.theme = SummaryTheme.light,
    this.isOpen = false,
  }) : super(key: key);

  Color get mainTextColor {
    Color textColor;
    if (theme == SummaryTheme.dark) textColor = Colors.white;
    if (theme == SummaryTheme.light) textColor = const Color(0xFF083e64);
    return textColor;
  }

  Color get secondaryTextColor {
    Color textColor;
    if (theme == SummaryTheme.dark) textColor = const Color(0xff61849c);
    if (theme == SummaryTheme.light) textColor = const Color(0xFF838383);
    return textColor;
  }

  Color get separatorColor {
    Color color;
    if (theme == SummaryTheme.light) color = const Color(0xffeaeaea);
    if (theme == SummaryTheme.dark) color = const Color(0xff396583);
    return color;
  }

  TextStyle get bodyTextStyle => TextStyle(
        color: mainTextColor,
        fontSize: 13,
        fontFamily: 'Oswald',
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBackgroundDecoration(),
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildLogoHeader(),
            _buildSeparationLine(),
            _buildTicketHeader(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildTicketOrigin(),
                  ),
                  Align(
                    child: _buildTicketDuration(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildTicketDestination(),
                  )
                ],
              ),
            ),
            _buildBottomIcon()
          ],
        ),
      ),
    );
  }

  Decoration _getBackgroundDecoration() {
    if (theme == SummaryTheme.light) {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      );
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      image: const DecorationImage(
        image: AssetImage('assets/images/bg_blue.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTicketOrigin() {
    return Column(
      children: [
        Text(
          boardingPass.origin.code.toUpperCase(),
          style: bodyTextStyle.copyWith(fontSize: 42),
        ),
        Text(
          boardingPass.origin.city,
          style: bodyTextStyle.copyWith(color: secondaryTextColor),
        ),
      ],
    );
  }

  Widget _buildLogoHeader() {
    //
    if (theme == SummaryTheme.light) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Image.asset('assets/images/flutter-logo.png', width: 8),
          ),
          Text('Fluttair'.toUpperCase(),
              style: TextStyle(
                color: mainTextColor,
                fontFamily: 'OpenSans',
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ))
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Image.asset('assets/images/logo_white.png', height: 12),
    );
  }

  Widget _buildSeparationLine() {
    return Container(
      width: double.infinity,
      height: 1,
      color: separatorColor,
    );
  }

  Widget _buildTicketHeader(BuildContext context) {
    //
    const _style = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      fontSize: 11,
      color: Color(0xFFe46565),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(boardingPass.passengerName.toUpperCase(), style: _style),
        Text(
          'BOARDING ${boardingPass.boardingTime.format(context)}',
          style: _style,
        ),
      ],
    );
  }

  Widget _buildBottomIcon() {
    IconData icon;
    if (theme == SummaryTheme.light) icon = Icons.keyboard_arrow_down;
    if (theme == SummaryTheme.dark) icon = Icons.keyboard_arrow_up;

    return Icon(
      icon,
      color: mainTextColor,
      size: 18,
    );
  }

  Widget _buildTicketDuration() {
    String planeRoutePath;
    if (theme == SummaryTheme.light) {
      planeRoutePath = 'assets/images/planeroute_blue.png';
    }
    if (theme == SummaryTheme.dark) {
      planeRoutePath = 'assets/images/planeroute_white.png';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 120,
          height: 58,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(planeRoutePath, fit: BoxFit.cover),
              if (theme == SummaryTheme.light)
                Image.asset(
                  'assets/images/airplane_blue.png',
                  height: 20,
                  fit: BoxFit.contain,
                ),
              if (theme == SummaryTheme.dark)
                _AnimatedSlideToRight(
                  isOpen: isOpen,
                  child: Image.asset(
                    'assets/images/airplane_white.png',
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                )
            ],
          ),
        ),
        Text(
          boardingPass.duration.toString(),
          textAlign: TextAlign.center,
          style: bodyTextStyle,
        ),
      ],
    );
  }

  Widget _buildTicketDestination() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          boardingPass.destination.code.toUpperCase(),
          style: bodyTextStyle.copyWith(fontSize: 42),
        ),
        Text(
          boardingPass.destination.city,
          style: bodyTextStyle.copyWith(color: secondaryTextColor),
        ),
      ],
    );
  }
}

class _AnimatedSlideToRight extends StatefulWidget {
  final Widget child;
  final bool isOpen;

  const _AnimatedSlideToRight({Key key, this.child, @required this.isOpen})
      : super(key: key);

  @override
  _AnimatedSlideToRightState createState() => _AnimatedSlideToRightState();
}

class _AnimatedSlideToRightState extends State<_AnimatedSlideToRight>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1700));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isOpen) _controller.forward(from: 0);
    return SlideTransition(
      position:
          Tween(begin: const Offset(-2, 0), end: const Offset(1, 0)).animate(
        CurvedAnimation(curve: Curves.easeOutQuad, parent: _controller),
      ),
      child: widget.child,
    );
  }
}
