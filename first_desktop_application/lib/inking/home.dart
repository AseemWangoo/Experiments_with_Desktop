import 'package:first_desktop_application/inking/models/dark_model.dart';
import 'package:first_desktop_application/inking/widgets/dark_ink_bar.dart';
import 'package:first_desktop_application/inking/widgets/dark_ink_content.dart';
import 'package:first_desktop_application/inking/widgets/dark_ink_controls.dart';
import 'package:first_desktop_application/inking/widgets/transition_container.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      body: ChangeNotifierProvider<TransitionModel>(
        create: (_) => TransitionModel(),
        child: Consumer<TransitionModel>(
          builder: (_, model, __) {
            //

            final _currentMode = model.currentMode;

            return Stack(
              children: [
                TransitionContainer(
                  child: DarkInkContent(darkMode: _currentMode),
                  darkModeValue: _currentMode,
                ),
                DarkInkBar(darkModeValue: _currentMode),
                DarkInkControls(darkModeValue: _currentMode),
              ],
            );
          },
        ),
      ),
    );
  }
}
