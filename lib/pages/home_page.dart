import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/configs/paths.dart';
import 'package:flutter_weather/configs/routes.dart';
import '../blocs/weather_bloc/weather_bloc.dart';
import '../models/weather.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherIsLoaded) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Hue",
              style: TextStyle(color: Colors.white),
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
                  child: Column(children: [
                    Text(
                      "${state.weather.temp.temp}°C",
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
                  ],),
                ),
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
