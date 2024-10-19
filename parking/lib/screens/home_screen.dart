import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/parking_data_model.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:parking/widgets/info_widget.dart';
import 'package:parking/services/parking_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void fetchData() async {
    // await fetchParkingDataServices();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<ParkingDataProvider>(
                builder: (context, value, child) {
                  if (value.isParkingDataLoading) {
                    return Text("Loading....");
                  } else {
                    if (value.getParkingData.data != null) {
                      // return Text("${value.getParkingData.data!.length}");
                      ParkingDataModel parkingDataModel = value.getParkingData;
                      print("Size ${parkingDataModel.data!.length}");
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
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      childAspectRatio: 1.5,
                                    ),
                                    itemCount: parkingDataModel.data!.length,
                                    itemBuilder: (context, index) {
                                      ParkingData parkingData =
                                          parkingDataModel.data![index];
                                      String? licensePlate =
                                          parkingData.licensePlate;
                                      int numberSpaces =
                                          parkingData.numberSpaces!;
                                      print(
                                          "parkingData[${index}] ${licensePlate}");
                                      // print(
                                      //     "parkingData ${parkingData.locationId}");
                                      // parkingData.licensePlate;

                                      // List<String> parts =
                                      //     parkingData.licensePlate!.split(':');

                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.black),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: licensePlate != null
                                                ? [
                                                    Text(
                                                      "No ${numberSpaces}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      licensePlate
                                                          .split(":")[0],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      licensePlate
                                                          .split(":")[1],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    )
                                                  ]
                                                : [
                                                    Text(
                                                      "No ${numberSpaces}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Vacant",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
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
                      return Text("empty");
                    }
                  }
                },
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Consumer<LocationProvider>(
                      builder: (context, value, child) {
                        print(
                            "value.getLocationList ${value.getLocationList.length}");

                        if (value.isLoading) {
                          return Center(
                            child: Text("Loading...."),
                          );
                        } else {
                          if (value.getLocationList.isNotEmpty) {
                            return DropdownButton2(
                              dropdownStyleData: const DropdownStyleData(
                                scrollPadding:
                                    EdgeInsets.only(left: 12, right: 0),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                padding: EdgeInsets.zero,
                              ),
                              alignment: Alignment.centerRight,
                              hint: Text(
                                'Select location',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                              items: value.getLocationList
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.id,
                                        child: Text(
                                          item.name!,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: value.getSelectLocation,
                              onChanged: (val) {
                                value.updateSelectLocation(val);
                                Provider.of<ParkingDataProvider>(context,
                                        listen: false)
                                    .fetchParkingData(val);
                              },
                            );
                          } else {
                            return Text("empty");
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
