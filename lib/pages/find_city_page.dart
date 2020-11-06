import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather/utils/shared_prefs.dart';
import '../models/location.dart';
import '../repository/weather_repository.dart';

class FindCityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Container(
        child: FindBody(),
      ),
    );
  }
}

class FindBody extends StatefulWidget {
  @override
  _FindBodyState createState() => _FindBodyState();
}

class _FindBodyState extends State<FindBody> {
  final _editingController = TextEditingController();

  String search;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              FindInput(
                editingController: _editingController,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20)),
                child: IconButton(
                  onPressed: () {
                    if (_editingController.text.isNotEmpty) {
                      setState(() {
                        search = _editingController.text;
                      });
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Location>>(
              future: WeatherRepository().searchCity(search),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isNotEmpty) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return FindItem(
                              location: snapshot.data[index],
                            );
                          });
                    } else {
                      return const Center(
                        child: Text("Empty :("),
                      );
                    }
                  } else {
                    return Container();
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              }),
        )
      ],
    );
  }
}

class FindItem extends StatelessWidget {
  final Location location;

  const FindItem({
    Key key,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: () {
          SharedPrefs().saveCurrentLocation(location.lon, location.lat);
          context.bloc<WeatherBloc>().add(
                FetchWeather(location.lon, location.lat),
              );
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListTile(
            title: Text(
              "${location.cityName} / ${location.countryName}",
            ),
            subtitle:
                // Text("${location.tempMin}°C - ${location.tempMax}°C"),
                Text("${location.lon} - ${location.lat}"),
            trailing: Text(
              "${location.temp}°C",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class FindInput extends StatelessWidget {
  final TextEditingController editingController;

  const FindInput({Key key, this.editingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(20)),
        child: TextField(
          controller: editingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    editingController.text = "";
                  }),
              hintText: "Search"),
        ),
      ),
    );
  }
}
