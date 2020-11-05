part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class WeatherIsLoading extends WeatherState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class WeatherIsLoaded extends WeatherState{
  final _weather;

  WeatherIsLoaded(this._weather);

  Weather get getWeather => _weather;

  @override
  // TODO: implement props
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}