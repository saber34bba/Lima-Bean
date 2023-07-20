import 'dart:convert';

import 'package:http/http.dart' as http;

class RestApi {
  Map<String, String> _header = {
    "Accept": "application/json",
    "content-type": "application/json",
    "Connection": "Keep-Alive"
  };

  dynamic getData(
    String url,
  ) async {
    var urldata = Uri.parse(url);

    try {
      var response = await http.get(urldata, headers: _header);

      return check(response);
    } catch (e) {
      return e;
    }
  }

  dynamic check(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return {response.statusCode: json.decode(response.body)};
      default:
        return {response.statusCode: json.decode(response.body)};
    }
  }
}
