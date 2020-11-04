part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherIsLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherIsLoaded extends WeatherState {
  final Weather weather;

  const WeatherIsLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

class WeatherIsNotLoaded extends WeatherState {
  @override
  List<Object> get props => [];
}
