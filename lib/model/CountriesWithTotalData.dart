import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/TotalData.dart';

class CountriesWithTotalData {
  CountriesWithTotalData._internal();

  CountriesData countriesData;
  TotalData totalData;

  static final CountriesWithTotalData _instance =
      CountriesWithTotalData._internal();

  static CountriesWithTotalData get instance => _instance;
}
