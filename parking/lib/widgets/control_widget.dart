import 'package:flutter/material.dart';
import 'package:parking/models/custom_exception.dart';
import 'package:parking/models/transaction/transaction_req_model.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:parking/providers/transaction_provider.dart';
import 'package:parking/widgets/vehicle_registration_widget.dart';
import 'package:provider/provider.dart';

class ControlWidget extends StatelessWidget {
  TransactionProvider transaction;
  ControlWidget({
    super.key,
    required this.transaction,
  });

  void dialogAlert(BuildContext context, bool isError, String text) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          isError ? "Error" : "Success",
          style: TextStyle(
            fontSize: 16,
            color: isError ? Colors.red : Colors.green,
          ),
        ),
        content: Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
                    fontWeight: FontWeight.bold,
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
                            !transaction.isLoading
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
                    child: Text(!transaction.isLoading ? "Ok" : "Loading..."),
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                VehicleRegistrationWidget(
                  selectProvince: transaction.getProvinceOut,
                  onChangedNumber: (val) {},
                  onChangedProvince: (val) {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
