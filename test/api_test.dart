import 'package:coronavirus/api/client.dart';
import 'package:coronavirus/model/Api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test for api response', () async {
    String token;
    await getApplicationToken().then((String value) {
      token = value;
    });

    var client = WebService(token: token);
    await client.fetchCountries().then((Api api) {
      expect('China', api.countries[0].name); // Passed
    });
  });
}
