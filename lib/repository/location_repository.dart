import 'package:flutter_weather/models/location.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Future<Location> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return Location(lon: position.longitude, lat: position.latitude);
  }
}
