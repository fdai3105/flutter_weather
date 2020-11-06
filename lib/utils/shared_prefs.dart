import '../configs/params.dart';
import '../models/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences sharedPreferences;

  static Future instance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future saveCurrentLocation(num lon, num lat) async {
    await sharedPreferences.setDouble(Params.coordLon, lon);
    await sharedPreferences.setDouble(Params.coordLat, lat);
  }

  Location getCurrentLocation() {
    final _lon = sharedPreferences.getDouble(Params.coordLon);
    final _lat = sharedPreferences.getDouble(Params.coordLat);
    return Location(lon: _lon, lat: _lat);
  }
}
