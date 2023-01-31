import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as ge;
import 'package:geolocator/geolocator.dart';

import '../state/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  String? address;
  String? address2;
  Position? position;

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      emit(LocationServiceState());

      log('Location services are disabled');

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        emit(LocationDeniedState());

        log('Location permissions are denied');

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      emit(LocationForeverState());

      log('Location permissions are permanently denied, we cannot request permissions');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<ge.Placemark> placeMarks = await ge.placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );

    address = placeMarks.first.country;
    address2 = placeMarks.first.locality;
    log('address: ${placeMarks.first.toJson()}');

    emit(GetLocationSuccessState());
  }

  List<dynamic> search = [];
  void getSearch(String value) {}
}
