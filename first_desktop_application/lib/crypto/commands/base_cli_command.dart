import 'package:args/command_runner.dart';

abstract class BaseCLICommand extends Command<dynamic> {
  String loadingMessage;

  @override
  Future<void> run();
}
