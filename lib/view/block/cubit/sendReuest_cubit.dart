
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/view/block/state/sendRequest_satate.dart';
import 'package:toordor/view/screen/show_bussnise_appointment.dart';

import '../../../const/new_url_links.dart';
import '../../../network/remote/api_request.dart';

class SendRequestCubit extends Cubit<SendRequestState> {
  SendRequestCubit() : super(SendRequestInitial());

  static SendRequestCubit get(context) => BlocProvider.of(context);

  Future<void> sendRequest({
    required BuildContext context,
    int? userId,
    TextEditingController ?message,
    int?serviceid,
  }) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    emit(SendRequestLoading());
    ApiRequest.postData(data: {
      // {"user_id":"4","service_id":"1","message":"Hello, Want To Join Us!","specialization":"Driver"}
      "user_id": userId,
      "message":message?.text,
      "service_id":serviceid
    }, path: ApiLinks.sendRequest, token: _token)
        .then((value) {
      if (value.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar( SnackBar(content: Text('تم ارسال الطلب للموظف'.tr())));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowBussniseAppointment()));

      }
    }).catchError((Error) {
      print("لرجاءالتحقق من البيانات");
      emit(SendRequestError("الرجاء التحقق من البيانات".tr()));
    });
  }
}
