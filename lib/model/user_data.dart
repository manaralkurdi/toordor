
class UserData {
  int? id;
  String? fullname;
  String? username;
  String? phone;
  Null? countryId;
  Null? cityId;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? photo;
  bool? hasBussinees;
  int? bussineesId;
  bool? isEmployee;
  int? employeeId;

  UserData(
      {this.id,
        this.fullname,
        this.username,
        this.phone,
        this.countryId,
        this.cityId,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.photo,
        this.hasBussinees,
        this.bussineesId,
        this.isEmployee,
        this.employeeId});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    phone = json['phone'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
    hasBussinees = json['has_bussinees'];
    bussineesId = json['bussinees_id'];
    isEmployee = json['is_employee'];
    employeeId = json['employee_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo'] = this.photo;
    data['has_bussinees'] = this.hasBussinees;
    data['bussinees_id'] = this.bussineesId;
    data['is_employee'] = this.isEmployee;
    data['employee_id'] = this.employeeId;
    return data;
  }
}