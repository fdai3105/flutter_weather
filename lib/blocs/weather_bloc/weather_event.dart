part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final city;

  const FetchWeather(this.city);

  @override
  List<Object> get props => [city];
}

class ResetWeather extends WeatherEvent {
  @override
  List<Object> get props => [];
}
