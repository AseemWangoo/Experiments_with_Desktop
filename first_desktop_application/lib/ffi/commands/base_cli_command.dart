import 'dart:io';

import 'package:args/command_runner.dart';

abstract class BaseCLICommand extends Command<dynamic> {
  String loadingMessage;

  void execCommand(String arg);
  Future<List<dynamic>> execFutureCommand(String arg);

  @override
  Future<void> run() async {
    if (argResults.arguments.isEmpty) {
      throw Exception('😳😳 Please specify the argument');
    }

    final arg = argResults.arguments.first;
    final loadingMsg = '$loadingMessage $arg';

    stdout.write('$loadingMsg\n');
    execCommand(arg);
  }
}
