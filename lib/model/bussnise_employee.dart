class BussniseEmployes {
  int? id;
  int? userId;
  int? serviceId;
  String? name;
  String? phone;
  Null? specialization;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  List<Workhours>? workhours;

  BussniseEmployes(
      {this.id,
        this.userId,
        this.serviceId,
        this.name,
        this.phone,
        this.specialization,
        this.createdAt,
        this.updatedAt,
        this.pivot,
        this.workhours});

  BussniseEmployes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    name = json['name'];
    phone = json['phone'];
    specialization = json['specialization'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    if (json['workhours'] != null) {
      workhours = <Workhours>[];
      json['workhours'].forEach((v) {
        workhours!.add(new Workhours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['service_id'] = this.serviceId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['specialization'] = this.specialization;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.workhours != null) {
      data['workhours'] = this.workhours!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? busineesId;
  int? employeeId;

  Pivot({this.busineesId, this.employeeId});

  Pivot.fromJson(Map<String, dynamic> json) {
    busineesId = json['businees_id'];
    employeeId = json['employee_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['businees_id'] = this.busineesId;
    data['employee_id'] = this.employeeId;
    return data;
  }
}

class Workhours {
  int? id;
  int? employeeId;
  int? busineesId;
  String? fromDate;
  String? toDate;
  String? breakFrom;
  String? breakTo;
  List<String>? weekends;
  String? createdAt;
  String? updatedAt;

  Workhours(
      {this.id,
        this.employeeId,
        this.busineesId,
        this.fromDate,
        this.toDate,
        this.breakFrom,
        this.breakTo,
        this.weekends,
        this.createdAt,
        this.updatedAt});

  Workhours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    busineesId = json['businees_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    breakFrom = json['break_from'];
    breakTo = json['break_to'];
    weekends = json['weekends'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['businees_id'] = this.busineesId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['break_from'] = this.breakFrom;
    data['break_to'] = this.breakTo;
    data['weekends'] = this.weekends;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}