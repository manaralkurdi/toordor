// class WorkhoursModels {
//   bool? error;
//   Message? message;
//
//   WorkhoursModels({this.error, this.message});
//
//   WorkhoursModels.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     message =
//     json['message'] != null ? new Message.fromJson(json['message']) : null;
//   }
// }

class WorkhoursModels {
  List<String>? busineesId;
  List<String>? fromDate;
  List<String>? toDate;
  List<String>? breakFrom;
  List<String>? breakTo;
  List<String>? weekends;

  WorkhoursModels(
      {this.busineesId,
        this.fromDate,
        this.toDate,
        this.breakFrom,
        this.breakTo,
        this.weekends});

  WorkhoursModels.fromJson(Map<String, dynamic> json) {
    busineesId =
    json['businees_id'] == null ? [] : json['businees_id'].cast<String>();
    fromDate =
    json['from_date'] == null ? [] : json['from_date'].cast<String>();
    toDate = json['to_date'] == null ? [] : json['to_date'].cast<String>();
    breakFrom =
    json['break_from'] == null ? [] : json['break_from'].cast<String>();
    breakTo = json['break_to'] == null ? [] : json['break_to'].cast<String>();
    weekends = json['weekends'] == null ? [] : json['weekends'].cast<String>();
  }
}