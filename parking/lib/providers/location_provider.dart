import 'package:flutter/material.dart';
import 'package:parking/models/location_model.dart';
import 'package:parking/services/parking_service.dart';

class LocationProvider extends ChangeNotifier {
  List<LocationModel> locationList = <LocationModel>[];
  String? selectLocation = null;
  bool isLoading = false;

  List<LocationModel> get getLocationList => locationList;
  void updateLocationList(l) {
    locationList = l;
  }

  String? get getSelectLocation => selectLocation;
  void updateSelectLocation(l) {
    selectLocation = l;
    notifyListeners();
  }

  Future<void> fetchLocation() async {
    isLoading = true;
    notifyListeners();
    try {
      final res = await fetchLocationServices();
      print("jsonData ${res}");
      updateLocationList(res);
    } catch (error) {
      print('Error fetching parking: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
