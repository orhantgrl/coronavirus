import 'package:coronavirus/api/client.dart';
import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/TotalData.dart';

class CountriesWithTotalData {
  final CountriesData countriesData;
  final TotalData totalData;

  CountriesWithTotalData({this.countriesData, this.totalData});

  factory CountriesWithTotalData.transaction(
      CountriesData _countriesData, TotalData _totalData) {
    return CountriesWithTotalData(
      countriesData: _countriesData,
      totalData: _totalData,
    );
  }
}

Future<CountriesWithTotalData> startTransaction() async {
  WebService webService = WebService();
  await getApplicationToken().then((String value) {
    webService.token = value;
  });

  var countriesData = await webService.fetchCountriesData();
  var totalData = await webService.fetchTotalData();

  return CountriesWithTotalData.transaction(
    countriesData,
    totalData,
  );
}
