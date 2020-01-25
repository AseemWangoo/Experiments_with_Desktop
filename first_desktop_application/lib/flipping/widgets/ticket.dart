import 'package:first_desktop_application/flipping/data/demo_data.dart';
import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  final BoardingPassData boardingPass;

  const Ticket({
    Key key,
    @required this.boardingPass,
  }) : super(key: key);

  TextStyle get bodyTextStyle => TextStyle(
        color: Color(0xFF083e64),
        fontSize: 13,
        fontFamily: 'Oswald',
      );

  @override
  Widget build(BuildContext context) {
    //

    return Container(
      decoration: _getBackgroundDecoration(),
      // width: double.infinity,
      // height: double.infinity,
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
                    alignment: Alignment.center,
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
    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: Colors.white,
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
          style: bodyTextStyle.copyWith(color: Color(0xFF838383)),
        ),
      ],
    );
  }

  Widget _buildLogoHeader() {
    //
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Image.asset('assets/images/flutter-logo.png', width: 8),
        ),
        Text('Fluttair'.toUpperCase(),
            style: TextStyle(
              color: Color(0xFF083e64),
              fontFamily: 'OpenSans',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ))
      ],
    );
  }

  Widget _buildSeparationLine() {
    //

    return Container(
      width: double.infinity,
      height: 1,
      color: Color(0xffeaeaea),
    );
  }

  Widget _buildTicketHeader(context) {
    //
    final _style = TextStyle(
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
    return Icon(
      Icons.keyboard_arrow_down,
      color: Color(0xFF083e64),
      size: 18,
    );
  }

  Widget _buildTicketDuration() {
    //
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 120,
            height: 58,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/planeroute_blue.png',
                  fit: BoxFit.cover,
                ),
                _AnimatedSlideToRight(
                  child: Image.asset(
                    'assets/images/airplane_blue.png',
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                  isOpen: true,
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
      ),
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
          style: bodyTextStyle.copyWith(color: Color(0xFF838383)),
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
        vsync: this, duration: Duration(milliseconds: 1700));
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
      position: Tween(begin: Offset(-2, 0), end: Offset(1, 0)).animate(
        CurvedAnimation(curve: Curves.easeOutQuad, parent: _controller),
      ),
      child: widget.child,
    );
  }
}
