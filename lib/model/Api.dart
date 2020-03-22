import 'package:coronavirus/model/Country.dart';

class Api {
  final String status;
  final List<Country> countiries;

  Api({this.status, this.countiries});

  factory Api.fromJson(Map<String, dynamic> json) {
    var list = json['result'] as List;
    print(list.runtimeType);
    List<Country> countryList = list.map((c) => Country.fromJson(c)).toList();
    
    return Api(
      status: json['status'],
      countiries: countryList
    );
  }
}