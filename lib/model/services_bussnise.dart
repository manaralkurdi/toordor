class ServicesBussnise {
  int? id;
  int? businessId;
  String? serviceName;
  String? duration;
  String? createdAt;
  String? updatedAt;

  ServicesBussnise(
      {this.id,
        this.businessId,
        this.serviceName,
        this.duration,
        this.createdAt,
        this.updatedAt});

  ServicesBussnise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    serviceName = json['service_name'];
    duration = json['duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
class Accsept {
  bool? success;
  List<Message>? message;

  Accsept({this.success, this.message});

  Accsept.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  int? busineesId;
  int? serviceId;
  Businees? businees;
  Service? service;
  Message({this.busineesId, this.serviceId, this.businees, this.service});

  Message.fromJson(Map<String, dynamic> json) {
    busineesId = json['businees_id'];
    serviceId = json['service_id'];
    businees = json['businees'] != null
        ? new Businees.fromJson(json['businees'])
        : null;
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businees_id'] = this.busineesId;
    data['service_id'] = this.serviceId;
    if (this.businees != null) {
      data['businees'] = this.businees!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Businees {
  int? id;
  String? businessName;

  Businees({this.id, this.businessName});

  Businees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    return data;
  }
}

class Service {
  int? id;
  String? serviceName;

  Service({this.id, this.serviceName});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    return data;
  }
}