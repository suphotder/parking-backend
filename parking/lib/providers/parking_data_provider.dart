import 'package:flutter/material.dart';
import 'package:parking/models/parking_data_model.dart';
import 'package:parking/services/parking_service.dart';

class ParkingDataProvider extends ChangeNotifier {
  ParkingDataModel parkingDataModel = ParkingDataModel();
  bool isParkingDataLoading = false;

  ParkingDataModel get getParkingData => parkingDataModel;
  void updateParkingData(d) {
    parkingDataModel = d;
    notifyListeners();
  }

  Future<void> fetchParkingData() async {
    isParkingDataLoading = true;
    notifyListeners();
    try {
      final res = await fetchParkingDataServices();
      updateParkingData(res);
    } catch (error) {
      print('Error fetching parking: $error');
    } finally {
      isParkingDataLoading = false;
      notifyListeners();
    }
  }
}
