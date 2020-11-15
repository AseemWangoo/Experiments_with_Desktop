// ignore_for_file: avoid_print

import 'dart:io';

import 'package:first_desktop_application/ffi/utils/terminal_blocks.dart';

import 'utils/ffi_helpers.dart';
import 'utils/functions.dart';

// Navigate to lib/ffi
// Run `dart cmd_line.dart`
void main(List<String> args) {
  print(args);
  // TODO(aseem): Read this https://pub.dev/packages/args

  if (!Platform.isMacOS) {
    throw UnsupportedError('Not supported OS ${Platform.operatingSystem}!');
  }

  // Show boy in terminal..
  TerminalBlock.blockBoy();

  stdout.writeln(
      'Enter system command, e.g last `username`, where username will be username@Macbook-Pro. ');

  final input = stdin.readLineSync();

  print(input);

  final FFIFunc ffiInstance = FFIFunc();
  final sysLib = ffiInstance.openSystemLibraryMacOS();
  // print(sysLib.handle);

  ffiInstance.processCommand(sysLib, Commands.recentLogin);
}

// Run from the ffi directory
// dart2native cmd_line.dart -o cmd_line
