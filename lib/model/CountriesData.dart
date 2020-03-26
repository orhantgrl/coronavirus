import 'package:coronavirus/model/Country.dart';

class CountriesData {
  final bool success;
  final List<Country> countries;

  CountriesData({this.success, this.countries});

  factory CountriesData.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    List<Country> countryList = list.map((c) => Country.fromJson(c)).toList();

    return CountriesData(success: json['success'], countries: countryList);
  }
}
