class LoginApi {
  String? token;
  String? tokenType;
  String? fullname;
  String? username;
  Null? country;
  Null? city;
  String? phone;

  LoginApi(
      {this.token,
        this.tokenType,
        this.fullname,
        this.username,
        this.country,
        this.city,
        this.phone});

  LoginApi.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
    fullname = json['fullname'];
    username = json['username'];
    country = json['country'];
    city = json['city'];
    phone = json['phone'];
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
    return data;
  }
}