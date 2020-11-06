import 'dart:convert' as convert;
import '../models/location.dart';

import '../configs/params.dart';
import '../configs/paths.dart';
import '../models/weather.dart';
import 'repository.dart';
import 'package:http/http.dart' as http;

class WeatherRepository implements WeatherRepositoryI {
  http.Client client = http.Client();
  final Map<String, String> _headers = {
    "x-rapidapi-key": "7c9ce819f2msh6ba9afa7a43de37p1853eejsnf4369d1154ba",
    "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
  };

  @override
  Future<List<Location>> searchCity(String cityName) async {
    if (cityName != null) {
      final _locations = <Location>[];
      final _json = await client.get(
          "${Paths.findCity}?${"q=$cityName"}&${"cnt=5"}&units=metric",
          headers: _headers);
      final _jsonResult = convert.jsonDecode(_json.body);
      final _list = List.from(_jsonResult["list"]);
      for (final i in _list) {
        _locations.add(Location.fromJson(i));
      }
      return _locations;
    } else {
      return [];
    }
  }

  @override
  Future<Weather> getCurrentWeather(num lon, num lat) async {
    final _json = await client.get(
        "${Paths.currentWeather}&${"lon=$lon"}&${"lat=$lat"}&units=metric&lang=vi",
        headers: _headers);
    final _jsonResult = convert.jsonDecode(_json.body);
    return Weather.fromJson(_jsonResult);
  }

  @override
  Future<List<Weather>> getWeatherForecast(String location) async {
    final _weathers = <Weather>[];
    final _json = await client.get("${Paths.forecastWeather}${"q=$location"}",
        headers: _headers);
    final _jsonResult = convert.jsonDecode(_json.body);
    final _listWeathers = List.from(_jsonResult["list"]);
    for (final i in _listWeathers) {
      final _tempWeather = i[Params.weather][0];
      final _tempTemp = i[Params.temp];
      final _weather = Weather(
        id: _tempWeather[Params.weatherID],
        weatherText: _tempWeather[Params.weatherMain],
        weatherDesc: _tempWeather[Params.weatherDecs],
        weatherIcon: _tempWeather[Params.weatherIcon],
        coordinate: null,
        temp: Temp(
          temp: _tempTemp["day"],
          tempMin: _tempTemp[Params.tempMin],
          tempMax: _tempTemp[Params.tempMax],
          pressure: i[Params.pressure],
          humidity: i[Params.humidity],
          feelLike: i[Params.feelLike]["day"],
        ),
        wind: Wind(
          speed: i[Params.windSpeed],
          deg: i[Params.windDeg],
        ),
        sunrise: DateTime.fromMillisecondsSinceEpoch(i[Params.sunRise] * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(i[Params.sunSet] * 1000),
        timeZone: i["dt"],
      );
      _weathers.add(_weather);
    }
    return _weathers;
  }

  @override
  void getHistoricalWeather() {}

  @override
  void getWeatherInDay() {}
}
