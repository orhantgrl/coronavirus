import 'dart:convert';
import 'dart:io';

import 'package:coronavirus/model/Api.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class WebService {
  final String url = 'https://api.collectapi.com/corona/countriesData';
  String token;

  Future<Api> fetchCountries() async {
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: token
    });

    if (response.statusCode == 200) {
      return Api.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Client error');
    }
  }
}

Future<String> getApplicationToken() async {
  final parsedJson =
      jsonDecode(await rootBundle.loadString('assets/config.json'));
  return parsedJson['token'];
}
