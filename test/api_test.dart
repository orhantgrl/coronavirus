import 'dart:convert';
import 'dart:io';

import 'package:coronavirus/model/TotalData.dart';
import 'package:coronavirus/model/CountriesData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  CountriesData countriesData;
  TotalData totalData;

  _testRequest({@required String url}) async {
    Client client = Client();
    return await client.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "" // Your secret api token :)
    });
  }

  test('Test for countries data', () async {
    final response = await _testRequest(
      url: "https://api.collectapi.com/corona/countriesData",
    );

    if (response.statusCode == 200) {
      countriesData = CountriesData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load countries data');
    }

    expect(false, countriesData.countries.isEmpty); // Passed
  });

  test('Test for total data', () async {
    final response = await _testRequest(
      url: "https://api.collectapi.com/corona/totalData",
    );

    if (response.statusCode == 200) {
      totalData = TotalData.fromJson(jsonDecode(response.body)['result']);
    } else {
      throw Exception('Failed to load countries data');
    }
    expect(0,
        isNot(num.parse(totalData.totalDeaths.replaceAll(',', '')))); // Passed
  });
}
