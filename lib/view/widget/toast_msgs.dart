import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showCustomToast({required String msg, bool isSuccess = false}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: isSuccess ? Colors.greenAccent : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
