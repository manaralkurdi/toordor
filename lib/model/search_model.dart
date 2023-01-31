class SearchModel {
  bool? success;
  Message? message;

  SearchModel({this.success, this.message});

  SearchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }
}

class Message {
  int? id;
  String? fullname;
  String? username;
  String? phone;

  String? createdAt;
  String? updatedAt;

  Message(
      {this.id,
      this.fullname,
      this.username,
      this.phone,
      this.createdAt,
      this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    phone = json['phone'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
