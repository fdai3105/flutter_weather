import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather/models/weather.dart';
import 'package:flutter_weather/repository/weather_repository.dart';

part 'forecast_event.dart';

part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  WeatherRepository weatherRepository;

  ForecastBloc(this.weatherRepository) : super(ForecastInitial());

  @override
  Stream<ForecastState> mapEventToState(
    ForecastEvent event,
  ) async* {
    if (event is FetchForecast) {
      yield ForecastProgress();
      final _weathers =
          await weatherRepository.getWeatherForecast(event.lon, event.lat);
      yield ForecastSuccess(_weathers);
    }
  }
}
