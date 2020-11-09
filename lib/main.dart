import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter_weather/blocs/forecast_bloc/forecast_bloc.dart';
import 'utils/shared_prefs.dart';
import 'repository/location_repository.dart';
import 'configs/routes.dart';
import 'blocs/weather_bloc/weather_bloc.dart';
import 'repository/weather_repository.dart';
import 'pages/home_page.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.instance();

  final _weatherRepository = WeatherRepository();
  final _locationRepository = LocationRepository();
  final _sharedPref = SharedPrefs();
  final _currentLocation = await _locationRepository.getCurrentPosition();
  await _sharedPref.saveCurrentLocation(
      _currentLocation.lon, _currentLocation.lat);

  runApp(MultiBlocProvider(providers: [
    BlocProvider<WeatherBloc>(create: (context) {
      return WeatherBloc(_weatherRepository)
        ..add(FetchWeather(_sharedPref.getCurrentLocation().lon,
            _sharedPref.getCurrentLocation().lat));
    }),
    BlocProvider<ConnectivityBloc>(create: (context) {
      return ConnectivityBloc()..add(CheckConnectivityEvent());
    }),
    BlocProvider<ForecastBloc>(create: (context) {
      return ForecastBloc(_weatherRepository)
        ..add(FetchForecast(_sharedPref.getCurrentLocation().lon,
            _sharedPref.getCurrentLocation().lat));
    }),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: Routes.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
