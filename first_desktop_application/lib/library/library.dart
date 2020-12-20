import 'dart:ffi' as ffi;

typedef hello_world_func = ffi.Void Function();
// Dart type definition for calling the C foreign function
typedef HelloWorld = void Function();
void main() {
  LibraryTest().openFromCLI();
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

    final HelloWorld hello = sysLib
        .lookup<ffi.NativeFunction<hello_world_func>>('hello_world')
        .asFunction();
    // Call the function
    hello();
  }
}
