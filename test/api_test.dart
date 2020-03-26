import 'package:coronavirus/api/client.dart';
import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/TotalData.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test for countries data', () async {
    var client = WebService();
    String token = ""; // Your secret api token :)

    client.token = token;
    await client.fetchCountriesData().then((CountriesData api) {
      expect('China', api.countries[0].name); // Passed
    });
  });

  test('Test for total data', () async {
    var client = WebService();
    String token = ""; // Your secret api token :)

    client.token = token;
    await client.fetchTotalData().then((TotalData data) {
      /* Check current death of number here: 
       * https://www.worldometers.info/coronavirus/coronavirus-death-toll/
       */
      expect('17,138', data.totalDeaths); // Passed
    });
  });
}
