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
      try {
        final weather =
            await weatherRepository.getCurrentWeather(event.city);
        yield WeatherIsLoaded(weather);
      } catch (_) {
        print(_);
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
