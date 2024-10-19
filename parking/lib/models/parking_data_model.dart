class ParkingDataModel {
  List<ParkingData>? data;
  int? parked;
  int? total;

  ParkingDataModel({this.data, this.parked, this.total});

  ParkingDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ParkingData>[];
      json['data'].forEach((v) {
        data!.add(new ParkingData.fromJson(v));
      });
    }
    parked = json['parked'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['parked'] = this.parked;
    data['total'] = this.total;
    return data;
  }
}

class ParkingData {
  String? id;
  String? licensePlate;
  String? locationId;
  int? numberSpaces;
  String? status;

  ParkingData(
      {this.id,
      this.licensePlate,
      this.locationId,
      this.numberSpaces,
      this.status});

  ParkingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    licensePlate = json['license_plate'];
    locationId = json['location_id'];
    numberSpaces = json['number_spaces'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['license_plate'] = this.licensePlate;
    data['location_id'] = this.locationId;
    data['number_spaces'] = this.numberSpaces;
    data['status'] = this.status;
    return data;
  }
}
