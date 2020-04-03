import 'package:coronavirus/model/CountriesData.dart';
import 'package:coronavirus/model/TotalData.dart';
import 'package:coronavirus/resource/api_provider.dart';

class Repository {
  final ApiProvider apiProvider = ApiProvider();

  Future<CountriesData> fetchCountriesData() =>
      apiProvider.fetchCountriesData();

  Future<TotalData> fetchTotalData() => apiProvider.fetchTotalData();
}
