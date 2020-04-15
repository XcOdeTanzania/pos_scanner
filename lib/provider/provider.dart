import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pos_scanner/api/api.dart';

class HttpRequestProvier {
  // Loads the list of available products from the repo.
  Future<Map<String, dynamic>> fetchShops() async {
    Map<String, dynamic> requestResponse = Map();

    try {
      final http.Response response = await http.get(api + "shops");
      requestResponse.putIfAbsent('status', () => response.statusCode);
    } on SocketException catch (_) {
      requestResponse.putIfAbsent('noInternet', () => true);
    } catch (error) {
      requestResponse.putIfAbsent('error', () => true);
    }

    return requestResponse;
  }

  //Post store....
  Future<bool> postStore({storeData, userId}) async {
    bool _isSuccessful = false;
    Map<String, String> _headers = {"Content-Type": "application/json"};

    try {
      final http.Response response = await http.post(
          api + 'store/' + userId.toString(),
          body: json.encode(storeData),
          headers: _headers);

      if (response.statusCode == 201) _isSuccessful = true;
    } catch (e) {
      print(e);
    }

    return _isSuccessful;
  }


   //Check Token....
  Future<bool> checkToken({tokenData}) async {
    bool _isSuccessful = false;
    Map<String, String> _headers = {"Content-Type": "application/json"};

    try {
      final http.Response response = await http.post(
          api + 'checkVoucher',
          body: json.encode(tokenData),
          headers: _headers);

      if (response.statusCode == 201) _isSuccessful = true;
    } catch (e) {
      print(e);
    }

    return _isSuccessful;
  }
}
