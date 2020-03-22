import 'dart:convert';
import 'dart:io';

import 'package:coronavirus/model/Country.dart';
import 'package:http/http.dart' as http;

class WebService {
  final String url = 'https://api.collectapi.com/corona/countriesData';
  final String token;

  WebService({this.token});

  Future<Country> fetchCountries() async {
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: token
    });

    if (response.statusCode == 200) {
      return Country.fromJson(json.decode(response.body));
    } else {
      throw new Exception('Client error');
    }
  }
}

Future<String> getApplicationToken() async {
  final json = jsonDecode(await new File('lib/api/config.json').readAsString());
  return json['token'];
}
