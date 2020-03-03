import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class BgWidget extends StatelessWidget {
  const BgWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlareActor(
      'assets/animations/spaceman.flr',
      alignment: Alignment.centerLeft,
      fit: BoxFit.cover,
      animation: 'Untitled',
    );
  }
}
