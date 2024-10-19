class TransactionReqModel {
  String? locationId;
  String? transactionId;
  String? licensePlate;
  String? type;

  TransactionReqModel(
      {this.locationId, this.transactionId, this.licensePlate, this.type});

  TransactionReqModel.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    transactionId = json['transaction_id'];
    licensePlate = json['license_plate'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.locationId;
    data['transaction_id'] = this.transactionId;
    data['license_plate'] = this.licensePlate;
    data['type'] = this.type;
    return data;
  }
}
