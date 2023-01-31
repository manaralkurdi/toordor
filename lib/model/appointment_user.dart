class AppointmentUser {
  int? id;
  int? userId;
  int? employeeId;
  dynamic  busineesId;
  dynamic comments;
  String? status;
  String? fromDate;
  String? toDate;
  String? dateDay;
  String? createdAt;
  String? updatedAt;
  Servicee? service;
  Bussnise? bussnise;

  AppointmentUser(
      {this.id,
        this.userId,
        this.employeeId,
        this.busineesId,
        this.comments,
        this.status,
        this.fromDate,
        this.toDate,
        this.dateDay,
        this.createdAt,
        this.updatedAt,this.service});

  AppointmentUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    employeeId = json['employee_id'];
    busineesId = json['businees_id'];
    comments = json['comments'];
    status = json['status'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    dateDay = json['date_day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
    json['service'] != null ? new Servicee.fromJson(json['service']) : null;
    bussnise =
    json['businees'] != null ? new Bussnise.fromJson(json['businees']) : null;
  }

}
class Servicee {
  int? id;
  String? serviceName;

  Servicee({this.id, this.serviceName});

  Servicee.fromJson(Map<String, dynamic> json) {
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

class Bussnise {
  int? id;
  String? BussniseName;

  Bussnise({this.id, this.BussniseName});

  Bussnise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    BussniseName = json['business_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.BussniseName;
    return data;
  }
}