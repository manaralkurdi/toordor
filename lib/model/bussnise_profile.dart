

class BussniseProfileModel {
  int? id;
  String? businessName;
  String? phone;
  String? email;
  String? fromDate;
  String? toDate;
  String? specialization;
  Null? weekends;
  String? cityId;
  String? countryId;
  String? image;

  BussniseProfileModel(
      {this.id,
        this.businessName,
        this.phone,
        this.email,
        this.fromDate,
        this.toDate,
        this.specialization,
        this.weekends,
        this.cityId,
        this.countryId,
        this.image});

  BussniseProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    phone = json['phone'];
    email = json['email'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    specialization = json['specialization'];
    weekends = json['weekends'];
    cityId = json['city_id'];
    countryId = json['country_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['specialization'] = this.specialization;
    data['weekends'] = this.weekends;
    data['city_id'] = this.cityId;
    data['country_id'] = this.countryId;
    data['image'] = this.image;
    return data;
  }
}
