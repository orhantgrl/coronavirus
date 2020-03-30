import 'package:coronavirus/resource/country_api_provider.dart';

import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/TotalData.dart';

class Repository {
  final CountryApiProvider countryApiProvider = CountryApiProvider();

  Future<CountriesData> fetchCountriesData() =>
      countryApiProvider.fetchCountriesData();

  Future<TotalData> fetchTotalData() => 
      countryApiProvider.fetchTotalData();
}
