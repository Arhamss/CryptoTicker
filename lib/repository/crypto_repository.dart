import 'dart:developer';
import 'package:bitcoin_ticker/services/api_service.dart';
import '../models/crypto_prices_model.dart';

class CryptoRepository {
  static const urlAppend = '/coins/markets?vs_currency=';

  // https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd

  static Future<List<CryptoPrices>> getCryptoPrices(
      {required String currency}) async {
    try {
      final response = await ApiService.getApi(endPoint: '$urlAppend$currency');
      if (response.statusCode == 200) {
        return cryptoPricesFromJson(response.body);
      } else {
        throw (response.statusCode);
      }
    } on Exception catch (e) {
      log('Exception thrown while getting crypto prices. Error is: $e');
      throw ('Exception thrown while getting crypto prices. Error is: $e');
    }
  }
}
