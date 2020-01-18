import 'package:first_desktop_application/routes/constants.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Begin...

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _OptionButton(
                buttonText: 'Theming',
                onTap: () => Navigator.pushNamed(context, themingRoute),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    Key key,
    @required this.buttonText,
    @required this.onTap,
  }) : super(key: key);

  ///Specify the button text...
  final String buttonText;

  ///Action on tap of the button....
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.white,
      color: Colors.blue,
      onPressed: onTap,
      child: Text(buttonText),
    );
  }
}
