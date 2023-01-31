class ServicesEmployee {
  int? id;
  int? userId;
  int? serviceId;
  String? name;
  String? phone;
  String? specialization;
  String? createdAt;
  String? updatedAt;

  ServicesEmployee({this.id,
    this.userId,
    this.serviceId,
    this.name,
    this.phone,
    this.specialization,
    this.createdAt,
    this.updatedAt});

  ServicesEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    name = json['name'];
    phone = json['phone'];
    specialization = json['specialization'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
