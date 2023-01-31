// class LoginResponse {
//   String? status;
//   String? statusmsg;
//   Data? data;
//
//   LoginResponse({this.status, this.statusmsg, this.data});
//
//   LoginResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     statusmsg = json['statusmsg'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['statusmsg'] = this.statusmsg;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? token;
//   String? expiration;
//   String? username;
//   String? userKey;
//   String? isAdmin;
//
//   Data(
//       {this.token, this.expiration, this.username, this.userKey, this.isAdmin});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     expiration = json['expiration'];
//     username = json['username'];
//     userKey = json['userKey'];
//     isAdmin = json['isAdmin'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = this.token;
//     data['expiration'] = this.expiration;
//     data['username'] = this.username;
//     data['userKey'] = this.userKey;
//     data['isAdmin'] = this.isAdmin;
//     return data;
//   }
// }

class LoginResponse {
  bool? success;
  LoginApiData? data;
  dynamic? message;

  LoginResponse({this.success, this.data, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? new LoginApiData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class LoginApiData {
  String? token;
  String? tokenType;
  String? fullname;
  String? username;
  String? country;
  String? city;
  String? phone;
  bool ?is_employee;
  bool ? has_bussinees;

  LoginApiData(
      {this.token,
      this.tokenType,
      this.fullname,
      this.username,
      this.country,
      this.city,
      this.phone,this.has_bussinees,this.is_employee});

  LoginApiData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
    fullname = json['fullname'];
    username = json['username'];
    country = json['country'];
    city = json['city'];
    phone = json['phone'];
    has_bussinees = json['has_bussinees'];
    is_employee = json['is_employee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['token_type'] = this.tokenType;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['country'] = this.country;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['has_bussinees'] = this.has_bussinees;
    data['is_employee'] = this.is_employee;
    return data;
  }
}
