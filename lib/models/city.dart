import 'weather.dart';

class City {
  int id;
  String name;
  String country;
  Coord coord;
  int population;
  int timezone;

  City(
      {this.id,
      this.name,
      this.country,
      this.coord,
      this.population,
      this.timezone});

  @override
  String toString() {
    return 'City{id: $id, name: $name, contry: $country, coord: $coord, population: $population, timezone: $timezone}';
  }
}
