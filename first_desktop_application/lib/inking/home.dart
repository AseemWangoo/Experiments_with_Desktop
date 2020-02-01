import 'package:first_desktop_application/inking/widgets/dark_ink_bar.dart';
import 'package:first_desktop_application/inking/widgets/dark_ink_content.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      body: Stack(
        children: [
          DarkInkContent(
            darkMode: true,
          ),
          DarkInkBar(darkModeValue: true),
        ],
      ),
    );
  }
}
