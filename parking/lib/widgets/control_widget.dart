import 'package:flutter/material.dart';
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
                            transaction.getProvinceIn != ""
                        ? () {
                            print(
                                "${locationId}: ${transaction.getNumberIn}:${transaction.getProvinceIn}");
                            TransactionReqModel reqModel = TransactionReqModel(
                              locationId: locationId,
                              licensePlate:
                                  "${transaction.getNumberIn}:${transaction.getProvinceIn}",
                              type: "on",
                            );
                            transaction.fetchTransaction(reqModel);
                          }
                        : null,
                    child: Text("Ok"),
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
