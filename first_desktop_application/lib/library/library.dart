import 'dart:ffi' as ffi;

typedef hello_world_func = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();

// C header typedef:
typedef SystemC = ffi.Void Function();

// Dart header typedef
typedef SystemDart = void Function();

void main() {
  // LibraryTest().openFromCLI();
  LibraryTest().filesFromCLI();
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
}
