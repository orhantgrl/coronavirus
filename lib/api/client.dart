import 'dart:convert';
import 'dart:io';

import 'package:coronavirus/model/Api.dart';
import 'package:http/http.dart' as http;

class WebService {
  final String url = 'https://api.collectapi.com/corona/countriesData';
  final String token;

  WebService({this.token});

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
  final parsedJson = jsonDecode(await File('lib/api/config.json').readAsString());
  return parsedJson['token'];
}
