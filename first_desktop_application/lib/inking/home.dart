import 'package:first_desktop_application/inking/models/dark_model.dart';
import 'package:first_desktop_application/inking/widgets/dark_ink_bar.dart';
import 'package:first_desktop_application/inking/widgets/dark_ink_content.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      body: ChangeNotifierProvider<TransitionModel>(
        builder: (_) => TransitionModel(),
        child: Consumer<TransitionModel>(
          builder: (_, model, __) {
            //

            final _currentMode = model.currentMode;

            return Stack(
              children: [
                DarkInkContent(
                  darkMode: _currentMode,
                ),
                DarkInkBar(darkModeValue: _currentMode),
              ],
            );
          },
        ),
      ),
    );
  }
}
