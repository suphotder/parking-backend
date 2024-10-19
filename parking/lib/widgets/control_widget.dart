import 'package:flutter/material.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:provider/provider.dart';

class ControlWidget extends StatelessWidget {
  ControlWidget({super.key});

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
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: double.infinity,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
