class ServiceModelEmployee {
  List<Data>? data;

  ServiceModelEmployee({this.data});

  ServiceModelEmployee.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? serviceName;
  String? image;

  Data({this.id, this.serviceName, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    image = json['image'];
  }
}