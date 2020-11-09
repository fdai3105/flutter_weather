part of 'forecast_bloc.dart';

abstract class ForecastEvent extends Equatable {
  const ForecastEvent();
}

class FetchForecast extends ForecastEvent {
  final num lon;
  final num lat;

  const FetchForecast(this.lon, this.lat);

  @override
  List<Object> get props => [lon, lat];
}
