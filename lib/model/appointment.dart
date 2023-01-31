class Appointments {
  int? businessId;
  int? employeeId;
  DateTime? date;
  DateTime? fromDate;
  DateTime? toDate;
  String? comment;

  Appointments({
    this.businessId,
    this.employeeId,
    this.date,
    this.fromDate,
    this.toDate,
    this.comment,
  });

  Appointments.fromJson(Map<String, dynamic> json) {
    businessId = json['business_id'];
    employeeId = json['employee_id'];
    date = json['date'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_id'] = this.businessId;
    data['employee_id'] = this.employeeId;
    data['date'] = this.date;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['comment'] = this.comment;
    return data;
  }
}
