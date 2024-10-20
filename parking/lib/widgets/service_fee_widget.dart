import 'package:flutter/material.dart';
import 'package:parking/models/transaction/transaction_req_model.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/service_fee_provider.dart';
import 'package:parking/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class ServiceFeeWidget extends StatelessWidget {
  TransactionProvider transaction;
  ServiceFeeProvider serviceFee;
  ServiceFeeWidget({
    super.key,
    required this.transaction,
    required this.serviceFee,
  });

  @override
  Widget build(BuildContext context) {
    String? locationId =
        Provider.of<LocationProvider>(context).getSelectLocation;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 150,
            minWidth: 150,
          ),
          child: ElevatedButton(
            onPressed: locationId != null &&
                    transaction.getNumberOut != "" &&
                    transaction.getProvinceOut != "" &&
                    !serviceFee.isLoading
                ? () {
                    TransactionReqModel reqModel = TransactionReqModel(
                      locationId: locationId,
                      licensePlate:
                          "${transaction.getNumberOut}:${transaction.getProvinceOut}",
                    );
                    serviceFee.fetchServiceFee(reqModel);
                  }
                : null,
            child: Text(!serviceFee.isLoading ? "Service fee" : "Loading..."),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          constraints: BoxConstraints(
            maxWidth: 150,
            minWidth: 150,
          ),
          child: Align(
            alignment: Alignment.center,
            child: serviceFee.transactionRes.amount != null
                ? Text(
                    "${serviceFee.transactionRes.amount} บาท",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : SizedBox(),
          ),
        ),
      ],
    );
  }
}
