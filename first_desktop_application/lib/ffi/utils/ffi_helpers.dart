class Dylibs {
  static const String systemDyLib = '/usr/lib/libSystem.dylib';

  static const String systemSymbolName = 'system';
}

class Commands {
  static String recentLogin(String userName) => 'last $userName';
}
// nm -a /usr/lib/libSystem.dylib
