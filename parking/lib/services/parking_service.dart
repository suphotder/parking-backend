import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:parking/models/location_model.dart';
import 'package:parking/models/parking_data_model.dart';
import 'package:parking/models/transaction/transaction_req_model.dart';
import 'package:parking/models/transaction/transaction_res_model.dart';

Future<List<LocationModel>> fetchLocationServices() async {
  try {
    final url = Uri.parse("http://127.0.0.1:5000/parking/location");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response = await http.get(url, headers: headers);
    switch (response.statusCode) {
      case 200:
        try {
          List<dynamic> jsonData = jsonDecode(response.body);
          List<LocationModel> model =
              jsonData.map((data) => LocationModel.fromJson(data)).toList();
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

Future<ParkingDataModel> fetchParkingDataServices(locationId) async {
  try {
    final url = Uri.parse(
        "http://127.0.0.1:5000/parking/space?locationId=${locationId}");
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

Future<TransactionResModel> fetchTransactionService(
    TransactionReqModel body) async {
  try {
    final url = Uri.parse("http://127.0.0.1:5000/parking/transaction");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    switch (response.statusCode) {
      case 200:
        try {
          TransactionResModel model =
              TransactionResModel.fromJson(jsonDecode(response.body));
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
