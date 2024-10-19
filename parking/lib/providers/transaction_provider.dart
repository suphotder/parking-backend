import 'package:flutter/material.dart';
import 'package:parking/models/custom_exception.dart';
import 'package:parking/models/transaction/transaction_req_model.dart';
import 'package:parking/models/transaction/transaction_res_model.dart';
import 'package:parking/models/vehicle_registration_model.dart';
import 'package:parking/services/parking_service.dart';

class TransactionProvider extends ChangeNotifier {
  VehicleRegistrationModel vehicleReg = VehicleRegistrationModel();
  TransactionResModel transactionRes = TransactionResModel();
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

  TransactionResModel get getTransactionRes => transactionRes;
  void updateTransactionRes(t) {
    transactionRes = t;
    notifyListeners();
  }

  Future<void> fetchTransaction(TransactionReqModel body) async {
    try {
      updateIsLoading(true);
      final res = await fetchTransactionService(body);
      updateTransactionRes(res);
    } on CustomException catch (e) {
      throw e;
    } finally {
      updateIsLoading(false);
    }
  }
}
