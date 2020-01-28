import 'package:first_desktop_application/inking/widgets/dark_ink_content.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(title: const Text('Inking')),
      body: DarkInkContent(
        darkMode: true,
      ),
    );
  }
}
