class TransactionResModel {
  int? amount;
  String? id;
  String? licensePlate;
  String? onTime;
  String? outTime;
  String? parkingSpacesId;
  String? paymentStatus;

  TransactionResModel(
      {this.amount,
      this.id,
      this.licensePlate,
      this.onTime,
      this.outTime,
      this.parkingSpacesId,
      this.paymentStatus});

  TransactionResModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    id = json['id'];
    licensePlate = json['license_plate'];
    onTime = json['on_time'];
    outTime = json['out_time'];
    parkingSpacesId = json['parking_spaces_id'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['id'] = this.id;
    data['license_plate'] = this.licensePlate;
    data['on_time'] = this.onTime;
    data['out_time'] = this.outTime;
    data['parking_spaces_id'] = this.parkingSpacesId;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}
