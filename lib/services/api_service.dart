import 'dart:developer';
import 'package:http/http.dart';

class ApiService {
  static const String baseUrl = 'https://api.coingecko.com/api/v3';

  static Future<Response> getApi({required String endPoint}) async {
    Response resp;
    try {
      resp = await get(Uri.parse('$baseUrl$endPoint'));
      if (resp.statusCode == 200) {
        return resp;
      } else {
        throw (resp.statusCode);
      }
    } on Exception catch (e) {
      log('Exception thrown while doing a GET on $endPoint. Error is: $e');
      throw ('Exception thrown while doing a GET on $endPoint. Error is: $e');
    }
  }
}
