import 'package:first_desktop_application/app-level/widgets/column_spacer.dart';
import 'package:first_desktop_application/app-level/widgets/custom_scaffold.dart';
import 'package:first_desktop_application/shared/extensions/textstyle_extension.dart';
import 'package:flutter/material.dart';

import 'library.dart';
import 'strings/strings.dart';

class LibraryUI extends StatefulWidget {
  const LibraryUI({Key key}) : super(key: key);

  @override
  _LibraryUIState createState() => _LibraryUIState();
}

class _LibraryUIState extends State<LibraryUI> {
  final instance = LibraryTest();

  TextStyle get _ts => Theme.of(context).textTheme.headline6.c(Colors.white);
  TextStyle get _ts5 => Theme.of(context).textTheme.headline5.c(Colors.white);

  String _resp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      enableDarkMode: true,
      titleText: LibraryStrings.title,
      child: ColumnSpacer(
        spacerWidget: const SizedBox(height: 16.0),
        children: [
          const Spacer(),
          Text(
            LibraryStrings.helloFromC,
            style: _ts5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton.icon(
                onPressed: () => _hello('Aseem'),
                icon: const Icon(Icons.library_books),
                label: const Text('Hello from C'),
              ),
              if (_resp != null) Text(_resp, style: _ts),
            ],
          ),
          RaisedButton.icon(
            onPressed: () => _openTemp(),
            icon: const Icon(Icons.desktop_mac),
            label: const Text('Open Cache Folder'),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _hello(String input) {
    _resp = instance.inputFromFlutterToC(input);
    setState(() {});
  }

  void _openTemp() {
    instance.filesFromFlutter();
  }
}
