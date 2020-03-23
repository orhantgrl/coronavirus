import 'package:coronavirus/model/Country.dart';

class Api {
  final bool success;
  final List<Country> countries;

  Api({this.success, this.countries});

  factory Api.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    print(list.runtimeType);
    List<Country> countryList = list.map((c) => Country.fromJson(c)).toList();

    return Api(success: json['success'], countries: countryList);
  }
}
