import 'package:flutter/material.dart';
import 'package:parking/models/parking_data_model.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:parking/widgets/info_widget.dart';
import 'package:parking/widgets/license_plate_widget.dart';

class ParkingWidget extends StatelessWidget {
  ParkingDataProvider parkingData;

  ParkingWidget({super.key, required this.parkingData});

  @override
  Widget build(BuildContext context) {
    if (parkingData.isLoading) {
      return Text("Loading....");
    } else {
      if (parkingData.getParkingData.data != null) {
        ParkingDataModel parkingDataModel = parkingData.getParkingData;
        return parkingDataModel.data!.length > 0
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InfoWidget(
                        text: "Total",
                        data: parkingDataModel.total.toString(),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      InfoWidget(
                        text: "Parked",
                        data: parkingDataModel.parked.toString(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: parkingDataModel.data!.length,
                      itemBuilder: (context, index) {
                        ParkingData parkingData = parkingDataModel.data![index];
                        String? licensePlate = parkingData.licensePlate;
                        int? numberSpaces = parkingData.numberSpaces;
                        return Card(
                          color: licensePlate == null
                              ? Colors.green[300]
                              : Colors.red[300],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: LicensePlateWidget(
                              licensePlate: licensePlate,
                              numberSpaces: numberSpaces,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: Text("Emtry data"),
              );
      } else {
        return Text("Empty");
      }
    }
  }
}
