part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final num lon;
  final num lat;

  const FetchWeather(this.lon, this.lat);

  @override
  List<Object> get props => [lon,lat];
}

class ResetWeather extends WeatherEvent {
  @override
  List<Object> get props => [];
}
