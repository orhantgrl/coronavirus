import 'package:coronavirus/resource/country_api_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test for decode json file and get secret token", () async {
    final String matcher = ""; // Put your secret token and test it
    var actual = await getApplicationToken();
    expect(actual, matcher); // Passed
  });
}
