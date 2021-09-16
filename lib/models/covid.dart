class Covid {
  final int confirmed;
  final int recovered;
  final int active;
  final int deaths;
  final int population;
  final String continent;
  final String country;
  final String updateDate;

  Covid({
    required this.confirmed,
    required this.recovered,
    required this.active,
    required this.deaths,
    required this.population,
    required this.continent,
    required this.country,
    required this.updateDate,
  });

  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
      confirmed: json['cases'],
      recovered: json['recovered'],
      active: json['active'],
      deaths: json['deaths'],
      population: json['population'],
      continent: json['continent'],
      country: json['country'],
      updateDate: json['UpdateDate'],
    );
  }
}
