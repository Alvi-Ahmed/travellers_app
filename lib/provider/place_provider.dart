// provider/movie_provider.dart

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../infrastructure/places_repo.dart';

import '../models/placesModel.dart';

class PlaceProvider with ChangeNotifier {
  final PlacesRepo placesRepo = PlacesRepo();

  IList<Places> allplaces = const IListConst<Places>([]);
  Position? currentLocation;
  bool loading = false;
  bool permissionGranted = false;
  void loadPlaces() async {
    loading = true;
    notifyListeners();
    if (!permissionGranted || currentLocation == null) {
      await getCurrentLocation();
    }

    final data = await placesRepo.getAllPlaces().run();

    data.fold((l) {
      print("error happend : $l");
    }, (r) {
      allplaces = r;
    });
    loading = false;

    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      permissionGranted = true;
      currentLocation = await Geolocator.getCurrentPosition();
    }
  }
}
