import 'dart:developer';

import 'package:http/http.dart';
import 'dart:convert';

class bitCoinTracker {
  bitCoinTracker(this.url);
  final String url;
  Future getCoinData() async {
    try {
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        throw (response.statusCode);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
