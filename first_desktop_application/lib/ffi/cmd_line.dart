import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

// C header typedef:
typedef SystemC = ffi.Int32 Function(ffi.Pointer<Utf8> command);

// Dart header typedef
typedef SystemDart = int Function(ffi.Pointer<Utf8> command);

void main() {
  final sysLib = openSystemLibraryMacOS();
  // print(sysLib.handle);

  int resp = processCommand(sysLib, Commands.recentLogin);
  print('Resp $resp');
}

ffi.DynamicLibrary openSystemLibraryMacOS() {
  final systemDyLib = ffi.DynamicLibrary.open(Dylibs.systemDyLib);
  return systemDyLib;
}

int processCommand(ffi.DynamicLibrary sysLib, String command) {
  final sysFunc =
      sysLib.lookupFunction<SystemC, SystemDart>(Dylibs.systemSymbolName);

  final cmd = Utf8.toUtf8(command);
  final result = sysFunc(cmd);

  free(cmd);
  return result;
}

class Dylibs {
  static const String systemDyLib = '/usr/lib/libSystem.dylib';

  static const String systemSymbolName = 'system';
}

class Commands {
  static const String recentLogin = 'last aseemwangoo';
}

// nm -a /usr/lib/libSystem.dylib
