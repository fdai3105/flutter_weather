import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/blocs/weather_bloc/weather_bloc.dart';
import 'package:flutter_weather/models/weather.dart';
import '../repository/weather_repository.dart';

class FindCityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state){
            if(state is WeatherIsNotSearched)
              return Container(
                padding: EdgeInsets.only(left: 32, right: 32,),
                child: Column(
                  children: <Widget>[
                    Text("Search Weather", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
                    Text("Hue", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),),
                    SizedBox(height: 24,),
                    TextFormField(
                      controller: cityController,

                      decoration: InputDecoration(

                        prefixIcon: Icon(Icons.search, color: Colors.white70,),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.white70,
                                style: BorderStyle.solid
                            )
                        ),

                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                style: BorderStyle.solid
                            )
                        ),

                        hintText: "City Name",
                        hintStyle: TextStyle(color: Colors.white70),

                      ),
                      style: TextStyle(color: Colors.white70),

                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        onPressed: (){
                          weatherBloc.add(FetchWeather(cityController.text));
                        },
                        color: Colors.lightBlue,
                        child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                      ),
                    )

                  ],
                ),
              );
            else if(state is WeatherIsLoading)
              return Center(child : CircularProgressIndicator());
            else if(state is WeatherIsLoaded)
              return ShowWeather(state.weather, cityController.text);
            else
              return Text("Error",style: TextStyle(color: Colors.white),);
          },
        )

      ],
    );
  }
}

class ShowWeather extends StatelessWidget {
  Weather weather;
  final city;

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 32, left: 32, top: 10),
        child: Column(
          children: <Widget>[
            Text(city,style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),

            Text(weather.temp.temp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 50),),
            Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(weather.temp.tempMin.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
                    Text("Min Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(weather.temp.tempMax.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
                    Text("Max Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: (){
                  BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                },
                color: Colors.lightBlue,
                child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

              ),
            )
          ],
        )
    );
  }
}
