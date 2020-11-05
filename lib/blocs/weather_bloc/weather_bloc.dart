import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather/models/weather.dart';
import 'package:flutter_weather/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
   WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event,) async* {
    if(event is FetchWeather){
      yield WeatherIsLoading();

      try{
        Weather weather = await weatherRepository.getCurrentWeather(event._city);
        yield WeatherIsLoaded(weather);
      }catch(_){
        print(_);
        yield WeatherIsNotLoaded();
      }
    }else if(event is ResetWeather){
      yield WeatherIsNotSearched();
    }
  }
}
