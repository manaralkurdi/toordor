// MyWorkPlace


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/new_url_links.dart';
import '../../../network/remote/api_request.dart';
import '../state/MyWorkPlace_state.dart';

class MyWorkPlaceCubit extends Cubit<MyWorkPlaceState> {
  MyWorkPlaceCubit() : super(MyWorkPlaceInitial());

  static MyWorkPlaceCubit get(context) => BlocProvider.of(context);

  Future<void> acceptRequest({
    int? requestId,
  }) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    emit(MyWorkPlaceAcceptRequestLoading());
    ApiRequest.postData(data: {
      "request_id": requestId,
    }, path: ApiLinks.acceptRequest, token: _token)
        .then((value) {
      if (value.statusCode == 200) {
        emit(MyWorkPlaceAcceptRequestSuccess());
      }
    }).catchError((Error) {
      print("faild");
      emit(MyWorkPlaceAcceptRequestError("الرجاء التحقق من البيانات"));
    });
  }

  Future<void> cancelRequest({
    int? requestId,
  }) async {
    String _token = await SharedPreferences.getInstance()
        .then((value) => value.getString('token') ?? '');
    emit(MyWorkPlaceCancelRequestLoading());
    ApiRequest.postData(data: {
      "request_id": requestId,
    }, path: ApiLinks.cancelRequest, token: _token)
        .then((value) {
      if (value.statusCode == 200) {
        emit(MyWorkPlaceCancelRequestSuccess());
      }
    }).catchError((Error) {
      emit(MyWorkPlaceCancelRequestError("الرجاء التحقق من البيانات"));
    });
  }

  // Future<void> sendRequest({
  //   String? userId,
  // }) async {
  //   String _token = await SharedPreferences.getInstance()
  //       .then((value) => value.getString('token') ?? '');
  //   emit(MyWorkPlaceSendRequestLoading());
  //   ApiRequest.postData(data: {

  //     // {"user_id":"4","service_id":"1","message":"Hello, Want To Join Us!","specialization":"Driver"}
  //     "user_id": userId,
  //     "user_id": '1',
  //     "user_id": 'Hello, Want To Join Us!',
  //     "user_id": 'Driver',
  //   }, path: ApiLinks.sendRequest, token: _token)
  //       .then((value) {
  //     if (value.statusCode == 200) {

  //       emit(MyWorkPlaceSendRequestSuccess());
  //     }
  //   }).catchError((Error) {
  //     emit(MyWorkPlaceSendRequestError("الرجاء التحقق من البيانات"));
  //   });
  // }

}
