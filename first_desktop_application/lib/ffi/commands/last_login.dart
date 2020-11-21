import 'package:first_desktop_application/ffi/commands/base_cli_command.dart';
import 'package:first_desktop_application/ffi/utils/ffi_helpers.dart';
import 'package:first_desktop_application/ffi/utils/functions.dart';

class LastLoginCmd extends BaseCLICommand {
  final cmdName = 'last_login';
  final desc = 'Gets the previously logged in data of the user';

  @override
  final loadingMessage = '🤡 🤡 🤡 Executing for the user :';

  @override
  String get description => desc;

  @override
  String get name => cmdName;

  @override
  void execCommand(String arg) {
    final FFIFunc ffiInstance = FFIFunc();
    final sysLib = ffiInstance.openSystemLibraryMacOS();

    ffiInstance.processCommand(sysLib, Commands.recentLogin(arg));
  }

  @override
  Future<List> execFutureCommand(String arg) => throw UnimplementedError();
}
