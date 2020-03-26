class TotalData {
  String totalDeaths;
  String totalCases;
  String totalRecovered;

  TotalData({this.totalDeaths, this.totalCases,  this.totalRecovered});

  factory TotalData.fromJson(Map<String, dynamic> json) {
    return TotalData(
      totalDeaths: json['totalDeaths'],
      totalCases: json['totalCases'],
      totalRecovered: json['totalRecovered']
    );
  }
}