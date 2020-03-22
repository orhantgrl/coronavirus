class Country {
  final String name;
  final String totalCases;
  final String newCases;
  final String totalDeaths;
  final String newDeaths;
  final String totalRecovered;
  final String activeCases;

  Country(
      {this.name,
      this.totalCases,
      this.newCases,
      this.totalDeaths,
      this.newDeaths,
      this.totalRecovered,
      this.activeCases});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        name: json['country'],
        totalCases: json['totalcases'],
        newCases: json['newCases'],
        totalDeaths: json['totaldeaths'],
        newDeaths: json['newDeaths'],
        totalRecovered: json['totalRecovered'],
        activeCases: json['activeCases']);
  }
}
