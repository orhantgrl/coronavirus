import 'dart:convert';
import 'dart:io';

import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/TotalData.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class WebService {
  final String countriesDataUrl = 'https://api.collectapi.com/corona/countriesData';
  final String totalDataUrl = 'https://api.collectapi.com/corona/totalData';
  String token;

  Future<CountriesData> fetchCountriesData() async {
    final response = await request(url: countriesDataUrl, token: token);

    if (response.statusCode == 200) {
      return CountriesData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Api client error check with debug option');
    }
  }

  Future<TotalData> fetchTotalData() async {
    final response = await request(url: totalDataUrl, token: token);

    if(response.statusCode == 200) {
      return TotalData.fromJson(jsonDecode(response.body)['result']);
    } else {
      throw Exception('Api client error check with debug option');
    }
  }
}

Future<http.Response> request({String url, String token}) async {
  return await http.get(url, headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: token
  });
}

Future<String> getApplicationToken() async {
  final parsedJson =
      jsonDecode(await rootBundle.loadString('assets/config.json'));
  return parsedJson['token'];
}
