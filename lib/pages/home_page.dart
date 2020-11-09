import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/forecast_bloc/forecast_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/connectivity_bloc/connectivity_bloc.dart';
import '../configs/routes.dart';
import '../blocs/weather_bloc/weather_bloc.dart';
import '../configs/paths.dart';
import '../models/weather.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivitySuccess) {
          return BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
            if (state is WeatherIsLoaded) {
              return Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    "${state.weather.cityName}, ${state.weather.countryName}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.find);
                      }),
                  actions: [
                    IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        onPressed: () {})
                  ],
                ),
                body: Container(
                  width: _size.width,
                  padding: const EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: backgroundImage(), fit: BoxFit.cover)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "${state.weather.temp.tempMin}°C",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.weather.weatherDesc,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Forecast(),
                      WeatherInfo(
                        weather: state.weather,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
        } else {
          return const Scaffold(
            backgroundColor: Colors.black54,
            body: Center(
              child: Text(
                "Pls check your internet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }

  ExactAssetImage backgroundImage() {
    final _now = DateTime.now().hour;
    if (_now <= 10) {
      // morning
      return const ExactAssetImage(
          "assets/images/backgrounds/background_morning.png");
    } else if (_now <= 14) {
      // noon
      return const ExactAssetImage(
          "assets/images/backgrounds/background_noon.png");
    } else if (_now <= 17) {
      // afternoon
      return const ExactAssetImage(
          "assets/images/backgrounds/background_afternoon.png");
    } else {
      // night
      return const ExactAssetImage(
          "assets/images/backgrounds/background_night.png");
    }
  }
}

class Forecast extends StatelessWidget {
  const Forecast({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBloc, ForecastState>(builder: (context, state) {
      if (state is ForecastSuccess) {
        return Container(
          height: 160,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.weathers.length,
              itemBuilder: (context, index) {
                final _date = DateTime.now().add(Duration(days: index));
                final _isNow = DateTime.now().day == _date.day;
                return Container(
                  margin: EdgeInsets.only(left: 5,
                      right: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        width: 100,
                        color: Colors.white.withOpacity(0.10),
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isNow
                                  ? "Today"
                                  : DateFormat("EEEE").format(_date),
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${state.weathers[index].temp.tempMin.toInt()}°C",
                              style: TextStyle(color: Colors.white),
                            ),
                            const Icon(Icons.arrow_drop_down,color: Colors.white,),
                            Text(
                              "${state.weathers[index].temp.tempMax.toInt()}°C",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(state.weathers[index].weatherText,
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("${state.weathers[index].wind.speed}m/s",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      } else {
        return Container();
      }
    });
  }
}

class WeatherInfo extends StatelessWidget {
  final Weather weather;

  const WeatherInfo({
    Key key,
    this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            color: Colors.white.withOpacity(0.10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Real feel",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${weather.temp.feelLike}°C",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        const Text("Wind speed",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text("${weather.wind.speed}m/s",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white.withOpacity(0.4),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: WeatherIcon(
                          weatherStatus: weather.weatherText,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Humidity",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text("${weather.temp.humidity}%",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24)),
                        const Divider(
                          color: Colors.white,
                        ),
                        const Text("Pressure",
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text("${weather.temp.pressure}hPa",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherIcon extends StatelessWidget {
  final String weatherStatus;

  const WeatherIcon({
    Key key,
    this.weatherStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (weatherStatus) {
      case "Rain":
        return Image.asset(
          '${Paths.assetIcons}icon_rain.png',
          height: 50,
        );
      default:
        return Image.asset('${Paths.assetIcons}icon_rain.png', height: 50);
    }
  }
}
