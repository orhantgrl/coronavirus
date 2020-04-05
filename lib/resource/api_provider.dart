import 'dart:convert';
import 'dart:io';

import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/TotalData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show Client;

class ApiProvider {
  final String _countriesDataUrl =
      'https://api.collectapi.com/corona/countriesData';
  final String _totalDataUrl = 'https://api.collectapi.com/corona/totalData';

  Future<CountriesData> fetchCountriesData() async {
    final response = await request(url: _countriesDataUrl);

    if (response.statusCode == 200) {
      return CountriesData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load countries data');
    }
  }

  Future<TotalData> fetchTotalData() async {
    final response = await request(url: _totalDataUrl);

    if (response.statusCode == 200) {
      return TotalData.fromJson(jsonDecode(response.body)['result']);
    } else {
      throw Exception('Failed to load total data');
    }
  }
}

request({@required String url}) async {
  Client client = Client();
  return await client.get(url, headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: await getApplicationToken()
  });
}

Future<String> getApplicationToken() async {
  final parsedJson =
      jsonDecode(await rootBundle.loadString('assets/config.json'));
  return parsedJson['token'];
}
