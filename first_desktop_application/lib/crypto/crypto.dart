import 'dart:io';

import 'api/crypto.api.dart';

Future<void> main() async {
  if (!Platform.isMacOS) {
    throw UnsupportedError('Not supported OS ${Platform.operatingSystem}!');
  }

  final data = await CrptoAPI().fetchData();

  print(data.bpi.usd.rateFloat.toString());
}
