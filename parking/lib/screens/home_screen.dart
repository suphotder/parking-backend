import 'package:flutter/material.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:parking/providers/transaction_provider.dart';
import 'package:parking/widgets/control_widget.dart';
import 'package:parking/widgets/select_widget.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Consumer<ParkingDataProvider>(
                  builder: (context, value, child) {
                    return ParkingWidget(parkingData: value);
                  },
                ),
              ),
              SizedBox(
                height: 12,
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
                      child: Consumer<TransactionProvider>(
                        builder: (context, value, child) {
                          return ControlWidget(transaction: value);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
