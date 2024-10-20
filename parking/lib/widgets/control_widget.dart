import 'package:flutter/material.dart';
import 'package:parking/models/custom_exception.dart';
import 'package:parking/models/transaction/transaction_req_model.dart';
import 'package:parking/models/transaction/transaction_res_model.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:parking/providers/service_fee_provider.dart';
import 'package:parking/providers/transaction_provider.dart';
import 'package:parking/widgets/service_fee_widget.dart';
import 'package:parking/widgets/util_widget.dart';
import 'package:parking/widgets/vehicle_registration_widget.dart';
import 'package:provider/provider.dart';

class ControlWidget extends StatelessWidget {
  TransactionProvider transaction;
  ControlWidget({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    String? locationId =
        Provider.of<LocationProvider>(context).getSelectLocation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFBDC4CB),
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "In",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Vehicle registration number",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                VehicleRegistrationWidget(
                  selectProvince: transaction.getProvinceIn,
                  onChangedNumber: (val) {
                    transaction.updateNumberIn(val);
                  },
                  onChangedProvince: (val) {
                    transaction.updateProvinceIn(val);
                  },
                ),
                Spacer(),
                Container(
                  constraints: BoxConstraints(maxWidth: 312),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: locationId != null &&
                            transaction.getNumberIn != "" &&
                            transaction.getProvinceIn != "" &&
                            !transaction.isLoadingIn
                        ? () async {
                            TransactionReqModel reqModel = TransactionReqModel(
                              locationId: locationId,
                              licensePlate:
                                  "${transaction.getNumberIn}:${transaction.getProvinceIn}",
                              type: "on",
                            );
                            await transaction.fetchTransaction(reqModel).then(
                              (value) {
                                dialogAlert(
                                    context, false, "Transaction completed.");
                                Provider.of<ParkingDataProvider>(context,
                                        listen: false)
                                    .fetchParkingData(locationId);
                              },
                              onError: (err) {
                                if (err is CustomException) {
                                  dialogAlert(context, true, err.message);
                                }
                              },
                            );
                          }
                        : null,
                    child: Text(!transaction.isLoadingIn ? "Ok" : "Loading..."),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 24,
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFBDC4CB),
              ),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "out",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Vehicle registration number",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                VehicleRegistrationWidget(
                  selectProvince: transaction.getProvinceOut,
                  onChangedNumber: (val) {
                    transaction.updateNumberOut(val);
                  },
                  onChangedProvince: (val) {
                    transaction.updateProvinceOut(val);
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Consumer<ServiceFeeProvider>(
                  builder: (context, value, child) {
                    return ServiceFeeWidget(
                      transaction: transaction,
                      serviceFee: value,
                    );
                  },
                ),
                Spacer(),
                Consumer<ServiceFeeProvider>(
                  builder: (context, value, child) {
                    TransactionResModel tranServiceFee =
                        value.getTransactionRes;
                    return Container(
                      constraints: BoxConstraints(maxWidth: 312),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: locationId != null &&
                                tranServiceFee.id != null &&
                                transaction.getNumberOut != "" &&
                                transaction.getProvinceOut != "" &&
                                !transaction.isLoadingOut
                            ? () async {
                                TransactionReqModel reqModel =
                                    TransactionReqModel(
                                  locationId: locationId,
                                  transactionId: tranServiceFee.id,
                                  licensePlate:
                                      "${transaction.getNumberOut}:${transaction.getProvinceOut}",
                                  type: "out",
                                );
                                await transaction
                                    .fetchTransaction(reqModel)
                                    .then(
                                  (val) {
                                    dialogAlert(context, false,
                                        "Transaction completed.");
                                    value.updateTransactionRes(
                                        TransactionResModel());
                                    Provider.of<ParkingDataProvider>(context,
                                            listen: false)
                                        .fetchParkingData(locationId);
                                  },
                                  onError: (err) {
                                    if (err is CustomException) {
                                      dialogAlert(context, true, err.message);
                                    }
                                  },
                                );
                              }
                            : null,
                        child: Text(
                            !transaction.isLoadingOut ? "Ok" : "Loading..."),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
