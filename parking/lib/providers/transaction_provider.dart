import 'package:flutter/material.dart';
import 'package:parking/models/transaction/transaction_req_model.dart';
import 'package:parking/models/vehicle_registration_model.dart';
import 'package:parking/services/parking_service.dart';

class TransactionProvider extends ChangeNotifier {
  VehicleRegistrationModel vehicleReg = VehicleRegistrationModel();
  bool isLoading = false;

  String get getNumberIn => vehicleReg.getNumberIn;
  void updateNumberIn(s) {
    vehicleReg.setNumberIn(s);
    notifyListeners();
  }

  String get getProvinceIn => vehicleReg.getProvinceIn;
  void updateProvinceIn(s) {
    vehicleReg.setProvinceIn(s);
    notifyListeners();
  }

  String get getNumberOut => vehicleReg.getNumberOut;
  void updateNumberOut(s) {
    vehicleReg.setNumberOut(s);
    notifyListeners();
  }

  String get getProvinceOut => vehicleReg.getProvinceOut;
  void updateProvinceOut(s) {
    vehicleReg.setProvinceOut(s);
    notifyListeners();
  }

  bool get getIsLoading => isLoading;
  void updateIsLoading(b) {
    isLoading = b;
    notifyListeners();
  }

  Future<void> fetchTransaction(TransactionReqModel body) async {
    try {
      updateIsLoading(true);
      final res = await fetchTransactionService(body);
    } catch (error) {
      print('Error fetching transaction: $error');
    } finally {
      updateIsLoading(false);
    }
  }
}
