part of 'forecast_bloc.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();
}

class ForecastInitial extends ForecastState {
  @override
  List<Object> get props => [];
}

class ForecastSuccess extends ForecastState {
  final List<Weather> weathers;

  const ForecastSuccess(this.weathers);
  @override
  List<Object> get props => [weathers];
}

class ForecastProgress extends ForecastState {
  @override
  List<Object> get props => [];
}

class ForecastFail extends ForecastState {
  @override
  List<Object> get props => [];
}
