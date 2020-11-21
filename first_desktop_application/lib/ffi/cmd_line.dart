// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:first_desktop_application/ffi/commands/last_login.dart';
import 'package:first_desktop_application/ffi/utils/terminal_blocks.dart';

// Navigate to lib/ffi
// Run `dart cmd_line.dart`
Future<void> main(List<String> args) async {
  if (!Platform.isMacOS) {
    throw UnsupportedError('Not supported OS ${Platform.operatingSystem}!');
  }

  // Show boy in terminal..
  TerminalBlock.blockBoy();

  final runner = CommandRunner<dynamic>(
    'last_login',
    'Info: Know previously logged in timestamps',
  );

  runner.addCommand(LastLoginCmd());

  final dynamic resp = await runner.run(args).catchError((dynamic exc) {
    stdout.write('❌ ❌ ❌ Error $exc');
    exitCode = 1;
  });

  return resp;
}

// Run from the ffi directory
// dart2native cmd_line.dart -o cmd_line

// void _extra() {
// final parser = ArgParser()
//   ..addOption(
//     'cmd',
//     abbr: 'c',
//     help: 'Strictly pass system commands',
//   )
//   ..addOption(
//     'system',
//     abbr: 's',
//     defaultsTo: Platform.operatingSystem,
//     help: 'The operating system to run tests on',
//     allowed: ['macos'],
//   )
//   ..addFlag(
//     'help',
//     abbr: 'h',
//     negatable: false,
//     help: 'Shows the available commands',
//   );

// final result = parser.parse(args);

// if (result.wasParsed('help')) {
//   print(parser.usage);
//   exit(0); // 0 = success
// }

// stdout.writeln(
//     'Enter system command, e.g last `username`, where username will be username@Macbook-Pro. ');

// final input = stdin.readLineSync();

// final FFIFunc ffiInstance = FFIFunc();
// final sysLib = ffiInstance.openSystemLibraryMacOS();
// // print(sysLib.handle);

// ffiInstance.processCommand(sysLib, Commands.recentLogin);
// }
