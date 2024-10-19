class LocationModel {
  String? id;
  String? name;
  int? totalSpaces;

  LocationModel({this.id, this.name, this.totalSpaces});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    totalSpaces = json['total_spaces'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['total_spaces'] = this.totalSpaces;
    return data;
  }
}
