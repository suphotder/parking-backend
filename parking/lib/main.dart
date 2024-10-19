import 'package:flutter/material.dart';
import 'package:parking/providers/location_provider.dart';
import 'package:parking/providers/parking_data_provider.dart';
import 'package:parking/providers/transaction_provider.dart';
import 'package:parking/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => LocationProvider()..fetchLocation(),
      ),
      ChangeNotifierProvider(
        create: (context) => ParkingDataProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => TransactionProvider(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F4F9),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0D3980)),
        primaryColor: const Color(0xFF0D3980),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF0D3980),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
