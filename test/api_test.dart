import 'package:coronavirus/api/client.dart';
import 'package:coronavirus/model/Country.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test for api response', () async {
    String token;
    await getApplicationToken().then((String value) {
      token = value;
    });

    var client = WebService(token: token);
    await client.fetchCountries().then((Country country) {
      expect('China', country.name);
    });
  });
}
