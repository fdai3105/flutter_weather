import '../configs/params.dart';

class Location {
  String cityName;
  String countryName;
  num lon;
  num lat;
  num temp;
  num tempMin;
  num tempMax;

  Location(
      {this.cityName,
      this.countryName,
      this.lon,
      this.lat,
      this.temp,
      this.tempMin,
      this.tempMax});

  factory Location.fromJson(json) {
    return Location(
      cityName: json[Params.name],
      countryName: json[Params.sys][Params.country],
      lon: json[Params.coord][Params.coordLon],
      lat: json[Params.coord][Params.coordLat],
      temp: json[Params.weatherMain][Params.temp],
      tempMin: json[Params.weatherMain][Params.tempMin],
      tempMax: json[Params.weatherMain][Params.tempMax],
    );
  }

  @override
  String toString() {
    return 'Location{cityName: $cityName, countryName: $countryName, lon: $lon, lat: $lat, temp: $temp}';
  }
}
