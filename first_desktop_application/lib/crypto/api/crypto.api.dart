import 'package:first_desktop_application/crypto/model/crypto.model.dart';
import 'package:http/http.dart' as http;

class CrptoAPI {
  static const String _url =
      'https://api.coindesk.com/v1/bpi/currentprice.json';

  Future<CryptoModel> fetchData() async {
    final http.Response resp = await http.get(Uri.parse(_url));
    final _mapResponse = cryptoModelFromJson(resp.body);

    return _mapResponse;
  }
}
