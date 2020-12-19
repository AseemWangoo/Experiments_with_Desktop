import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

typedef hello_world_func = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();
void main() {
  LibraryTest().open();
}

class LibraryTest {
  void open() {
    final sysLib = ffi.DynamicLibrary.open('./dylib/libhello.dylib');

    final HelloWorld hello = sysLib
        .lookup<ffi.NativeFunction<hello_world_func>>('hello_world')
        .asFunction();
    // Call the function
    hello();

    // final sysFunc = sysLib.lookupFunction<SystemC, SystemDart>('sayCheese');
    // final cmd = Utf8.toUtf8("sds");
    // print('First byte is: ${cmd.cast<ffi.Uint8>().value}');
    // print(Utf8.fromUtf8(cmd));
    // sysFunc(cmd);

    // free(cmd);

    // final int Function(String x) nativeCheese = sysLib
    //     .lookup<ffi.NativeFunction<ffi.Int32 Function(String)>>('sayCheese')
    //     .asFunction();

    // nativeCheese('yoo');

    // final helloWorldPointer =
    //     sysLib.lookup<ffi.NativeFunction<hello_world_func>>('sayCheese');
    // final helloWorld = helloWorldPointer.asFunction<hello_world_func>();
    // final messagePointer = helloWorld();
    // final message = Utf8.toUtf8('messagePointer');

    // final maxPointer = sysLib.lookup<ffi.NativeFunction<max_func>>('sayCheese');
    // final max = maxPointer.asFunction<cheese>();
  }
}
