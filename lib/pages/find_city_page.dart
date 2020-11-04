import 'package:flutter/material.dart';
import '../repository/weather_repository.dart';

class FindCityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        child: TextField(
          onChanged: (value) {
          },
        ),
      )),
    );
  }
}
