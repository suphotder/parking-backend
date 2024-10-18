import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:parking/models/parking_data_model.dart';

Future<ParkingDataModel> fetchParkingDataServices() async {
  print("fetchParkingDataServices");
  try {
    final url = Uri.parse(
        "http://127.0.0.1:5000/parking/space?locationId=f360b7bf-43f9-4ac5-bcf0-52e03b9bfcce");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.get(url, headers: headers);
    switch (response.statusCode) {
      case 200:
        try {
          ParkingDataModel model =
              ParkingDataModel.fromJson(jsonDecode(response.body));
          return model;
        } catch (e) {
          print("[Error]:$e");
          rethrow;
        }
      default:
        throw Exception(response.reasonPhrase);
    }
  } on SocketException catch (_) {
    rethrow;
  }
}
