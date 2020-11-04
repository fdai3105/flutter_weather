import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../repository/weather_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WeatherRepository().getWeatherForecast("Hue");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Hue",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(
              Icons.add,
              color: Colors.black87,
            ),
            onPressed: () {}),
        actions: [
          IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black87,
              ),
              onPressed: () {})
        ],
      ),
      body: SafeArea(child: Container()),
    );
  }
}