import 'package:flutter/material.dart';
import 'package:parking/models/parking_data_model.dart';
import 'package:parking/services/parking_service.dart';

class ParkingDataProvider extends ChangeNotifier {
  ParkingDataModel parkingDataModel = ParkingDataModel();
  bool isLoading = false;

  ParkingDataModel get getParkingData => parkingDataModel;
  void updateParkingData(d) {
    parkingDataModel = d;
  }

  Future<void> fetchParkingData(locationId) async {
    isLoading = true;
    notifyListeners();
    try {
      final res = await fetchParkingDataServices(locationId);
      updateParkingData(res);
    } catch (error) {
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
