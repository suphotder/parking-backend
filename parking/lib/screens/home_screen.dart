import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/parking_data_model.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:parking/widgets/control_widget.dart';
import 'package:parking/widgets/select_widget.dart';
import 'package:parking/widgets/info_widget.dart';
import 'package:parking/services/parking_service.dart';
import 'package:parking/widgets/license_plate_widget.dart';
import 'package:parking/widgets/parking_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<ParkingDataProvider>(
                builder: (context, value, child) {
                  return ParkingWidget(parkingData: value);
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Consumer<LocationProvider>(
                    builder: (context, value, child) {
                      return SelectWidget(location: value);
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ControlWidget(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
