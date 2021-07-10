import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

typedef hello_world_func = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();

// C header typedef:
typedef SystemC = ffi.Void Function();

// Dart header typedef
typedef SystemDart = void Function();

typedef SystemCHello = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8> str);
typedef SystemDartHello = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8> str);

void main() {
  // final instance = LibraryTest();

  // instance.openFromCLI();
  // instance.filesFromCLI();
  // instance.helloFromCLI();
}

class LibraryTest {
  void openFromFlutter() {
    final sysLib = ffi.DynamicLibrary.open('libhello.dylib');

    final HelloWorld hello = sysLib
        .lookup<ffi.NativeFunction<hello_world_func>>('hello_world')
        .asFunction();
    // Call the function
    hello();
  }

  String inputFromFlutterToC(String input) {
    final sysLib = ffi.DynamicLibrary.open('libfetchtemp.dylib');

    final helloFromC =
        sysLib.lookupFunction<SystemCHello, SystemDartHello>('sayHello');

    // Pass input
    final name = input.toNativeUtf8();

    // Call the function
    final res = helloFromC(name);

    // Convert resp into string
    final strRes = res.toDartString();
    // ignore: avoid_print
    print(strRes);
    return strRes;
  }

  void filesFromFlutter() {
    final sysLib = ffi.DynamicLibrary.open('libfetchtemp.dylib');

    final tempFiles =
        sysLib.lookupFunction<SystemC, SystemDart>('fetchtemp_files');
    // Call the function
    tempFiles();
  }

  void openFromCLI() {
    final sysLib = ffi.DynamicLibrary.open('./dylib/libhello.dylib');

    final hello = sysLib.lookupFunction<SystemC, SystemDart>('hello_world');

    // final HelloWorld hello = sysLib
    //     .lookup<ffi.NativeFunction<hello_world_func>>('hello_world')
    //     .asFunction();

    // Call the function
    hello();
  }

  void filesFromCLI() {
    final sysLib = ffi.DynamicLibrary.open('./dylib/libfetchtemp.dylib');

    final tempFiles =
        sysLib.lookupFunction<SystemC, SystemDart>('fetchtemp_files');
    // Call the function
    tempFiles();
  }

  void helloFromCLI() {
    final sysLib = ffi.DynamicLibrary.open('./dylib/libfetchtemp.dylib');

    final helloFromC =
        sysLib.lookupFunction<SystemCHello, SystemDartHello>('sayHello');

    // Pass input
    final name = 'Aseem'.toNativeUtf8();

    // Call the function
    final res = helloFromC(name);

    // Convert resp into string
    final strRes = res.toDartString();
    // ignore: avoid_print
    print(strRes);
  }
}
