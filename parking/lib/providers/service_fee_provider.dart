import 'package:flutter/material.dart';
import 'package:parking/models/custom_exception.dart';
import 'package:parking/models/transaction/transaction_req_model.dart';
import 'package:parking/models/transaction/transaction_res_model.dart';
import 'package:parking/services/parking_service.dart';

class ServiceFeeProvider extends ChangeNotifier {
  TransactionResModel transactionRes = TransactionResModel();
  bool isLoading = false;

  TransactionResModel get getTransactionRes => transactionRes;
  void updateTransactionRes(t) {
    transactionRes = t;
    notifyListeners();
  }

  bool get getIsLoading => isLoading;
  void updateIsLoading(b) {
    isLoading = b;
    notifyListeners();
  }

  Future<void> fetchServiceFee(TransactionReqModel body) async {
    try {
      updateIsLoading(true);
      final res = await fetchServiceFeeService(body);
      updateTransactionRes(res);
    } on CustomException catch (e) {
      throw e;
    } finally {
      updateIsLoading(false);
    }
  }
}
