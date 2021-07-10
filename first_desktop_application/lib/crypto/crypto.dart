import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:first_desktop_application/crypto/commands/crypto.dart';

Future<void> main(List<String> args) async {
  if (!Platform.isMacOS) {
    throw UnsupportedError('Not supported OS ${Platform.operatingSystem}!');
  }
  final rainBow = Runes('\u{1F308}');

  stdout.writeln(
    '>>>>>>>> FETCHING BTC PRICE >>>>>>> ${String.fromCharCodes(rainBow)}',
  );
  stdout.writeln('');

  final runner = CommandRunner<dynamic>(
    'btc',
    'Info: Know the price of BTC.',
  );

  runner.addCommand(CryptoCmd());
  // runner.addCommand(HelloCmd());

  final dynamic resp = await runner.run(args).catchError((dynamic exc) {
    stdout.writeln('❌ ❌ ❌ Error $exc');
    exitCode = 1;
  });

  return resp;
}
