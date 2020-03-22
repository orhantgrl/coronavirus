class Country {
  final String name;
  final int totalCases;
  final int newCases;
  final int totalDeaths;
  final int newDeaths;
  final int totalRecovered;
  final int activeCases;

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
        name: json['result[country]'],
        totalCases: json['result[0][1]'],
        newCases: json['result[0][2]'],
        totalDeaths: json['result[0][3]'],
        newDeaths: json['result[0][4]'],
        totalRecovered: json['result[0][5]'],
        activeCases: json['result[0][6]']);
  }
}
