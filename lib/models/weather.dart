import '../configs/parameters.dart';

class Temp {
  num temp;
  num tempMin;
  num tempMax;
  num feelLike;
  int pressure;
  int humidity;

  Temp(
      {this.temp,
      this.tempMin,
      this.tempMax,
      this.feelLike,
      this.pressure,
      this.humidity});

  @override
  String toString() {
    return 'Temp{temp: $temp, tempMin: $tempMin, tempMax: $tempMax, feelLike: $feelLike, pressure: $pressure, humidity: $humidity}';
  }
}

class Coordinate {
  double longitude;
  double latitude;

  Coordinate({this.longitude, this.latitude});

  @override
  String toString() {
    return 'Coordinate{longitude: $longitude, latitude: $latitude}';
  }
}

class Wind {
  double speed;
  int deg;

  Wind({this.speed, this.deg});

  @override
  String toString() {
    return 'Wind{speed: $speed, deg: $deg}';
  }
}

class Weather {
  int id;
  String weatherText;
  String weatherDesc;
  String weatherIcon;
  Coordinate coordinate;
  Temp temp;
  Wind wind;
  DateTime sunrise;
  DateTime sunset;
  int timeZone;

  Weather(
      {this.id,
      this.weatherText,
      this.weatherDesc,
      this.weatherIcon,
      this.coordinate,
      this.temp,
      this.wind,
      this.sunrise,
      this.sunset,
      this.timeZone});

  factory Weather.fromJson(json) {
    return Weather(
      id: json[Params.weatherID],
      weatherText: json["weather"][0][Params.weatherMain],
      weatherDesc: json["weather"][0][Params.weatherDecs],
      weatherIcon: json["weather"][0][Params.weatherIcon],
      coordinate: Coordinate(
        longitude: json[Params.coord][Params.coordLon],
        latitude: json[Params.coord][Params.coordLat],
      ),
      temp: Temp(
        temp: json[Params.weatherMain][Params.temp],
        tempMin: json[Params.weatherMain][Params.tempMin],
        tempMax: json[Params.weatherMain][Params.tempMax],
        feelLike: json[Params.weatherMain][Params.feelLike],
        humidity: json[Params.weatherMain][Params.humidity],
        pressure: json[Params.weatherMain][Params.pressure],
      ),
      wind: Wind(
        speed: json[Params.wind][Params.windSpeed],
        deg: json[Params.wind][Params.windDeg],
      ),
      sunrise: DateTime.fromMicrosecondsSinceEpoch(json["sys"][Params.sunRise] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json["sys"][Params.sunSet] * 1000),
      timeZone: json[Params.timeZone],
    );
  }

  @override
  String toString() {
    return 'Weather{id: $id, weatherText: $weatherText, weatherDesc: $weatherDesc,'
        ' weatherIcon: $weatherIcon, coordinate: $coordinate, temp: $temp, wind: $wind,'
        ' sunrise: $sunrise, sunset: $sunset, timeZone: $timeZone}';
  }
}
