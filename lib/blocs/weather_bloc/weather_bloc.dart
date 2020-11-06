import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/weather.dart';
import '../../repository/weather_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherIsLoading();
      final weather =
          await weatherRepository.getCurrentWeather(event.lon, event.lat);
      yield WeatherIsLoaded(weather);
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
