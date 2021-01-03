import 'dart:io';

import 'package:first_desktop_application/crypto/api/crypto.api.dart';

import 'base_cli_command.dart';

class CryptoCmd extends BaseCLICommand {
  final cmdName = 'btc';
  final desc = 'Shows the price of Bitcoin';

  static CrptoAPI cryptoAPI = CrptoAPI();

  @override
  String get description => desc;

  @override
  String get name => cmdName;

  @override
  Future<void> run() async {
    final data = await cryptoAPI.fetchData();
    stdout.writeln('USD: ${data.bpi.usd.rateFloat}');
    stdout.writeln('EUR: ${data.bpi.eur.rateFloat}');
    stdout.writeln('POUND: ${data.bpi.gbp.rateFloat}');
    stdout.writeln('');
    stdout.writeln('Updated at: ${data.time.updated}');
    stdout.writeln('Price by: ${data.disclaimer}');
    stdout.writeln('');
  }
}
