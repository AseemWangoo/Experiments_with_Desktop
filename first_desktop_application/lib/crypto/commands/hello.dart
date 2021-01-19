import 'dart:io';

import 'package:first_desktop_application/crypto/commands/base_cli_command.dart';

class HelloCmd extends BaseCLICommand {
  @override
  String get description => 'Say hello';

  @override
  String get name => 'hello';

  @override
  Future<void> run() async {
    stdout.writeln('Hello Folks!!!');
  }
}
