class ServicesIndexOfbussnise {
  int? id;
  String? serviceName;
  dynamic duration;
  String? image;

  ServicesIndexOfbussnise(
      {this.id, this.serviceName, this.duration, this.image});

  ServicesIndexOfbussnise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    duration = json['duration'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['duration'] = this.duration;
    data['image'] = this.image;
    return data;
  }
}
