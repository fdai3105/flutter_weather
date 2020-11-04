import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/weather_bloc/weather_bloc.dart';
import 'repository/weather_repository.dart';
import 'pages/home_page.dart';

void main() {
  final _weatherRepository = WeatherRepository();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<WeatherBloc>(create: (context) {
      return WeatherBloc(_weatherRepository)..add(const FetchWeather("Hue"));
    }),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
