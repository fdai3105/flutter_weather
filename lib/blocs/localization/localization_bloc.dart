import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationInitial());

  @override
  Stream<LocalizationState> mapEventToState(LocalizationEvent event,) async* {
    if (event is CheckPermission) {
      LocationPermission locationPermission = await Geolocator
          .checkPermission();
      print(locationPermission);
      yield getStateClass(locationPermission);
    } else if (event is RequestPermission) {
      LocationPermission permission = await Geolocator.requestPermission();
      yield getStateClass(permission);
    } else if (event is GetLocation) {
      Position position =
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .catchError((error) => print(error))
          .catchError((error) => print(error));
      if (position == null ||
          (position.latitude == 0.0 && position.longitude == 0.0))
        position =
        await Geolocator
            .getLastKnownPosition(); //If current position is not significant use last known position
      var coordinates = new Coordinates(position.latitude, position.longitude);
      var city;
      try {
        var location =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
        city = splitAddressLine(location.first.addressLine);
        yield LocationSucceed(city);
      } catch (error) {
        print(error);
        yield LocationFailed();
      }
    }
  }

  String splitAddressLine(String address) {
    var sp = address.split(",");
    return sp[sp.length - 2].split("/").removeLast();
  }

  LocalizationState getStateClass(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
        return Always();
        break;
      case LocationPermission.denied:
        return Denied();
        break;
      case LocationPermission.deniedForever:
        return DeniedForever();
        break;
      case LocationPermission.whileInUse:
        return WhileInUse();
      default:
        return Always();
    }
  }
}
