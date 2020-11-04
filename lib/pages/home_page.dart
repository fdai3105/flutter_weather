import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/weather_bloc/weather_bloc.dart';
import '../models/weather.dart';
import '../repository/weather_repository.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherIsLoaded) {
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
          body: SafeArea(
              child: Container(
            width: _size.width,
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${state.weather.temp.temp} C",
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: _size.width / 2 - 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Real feel"),
                            Text("${state.weather.temp.feelLike} C"),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Wind speed"),
                            Text("${state.weather.wind.speed} C"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: 1,
                          height: 100,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: _size.width / 2 - 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Humidity"),
                            Text("${state.weather.temp.humidity} C"),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Pressure"),
                            Text("${state.weather.temp.pressure} C"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
