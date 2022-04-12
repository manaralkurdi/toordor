import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toordor/Model/login_model.dart';
import 'package:toordor/View/Screen/AddProject.dart';
import 'package:toordor/View/Screen/Home.dart';
import 'package:toordor/View/Screen/MyBusiness.dart';
import 'package:toordor/View/Screen/MyEmployees.dart';
import 'package:toordor/View/Screen/UserProfile.dart';
import 'package:toordor/View/Screen/homeBody.dart';
import 'package:toordor/const/color.dart';
import 'package:http/http.dart' as http;
import 'package:toordor/const/urlLinks.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class Controller {
  showEmployee(BuildContext context) {
    empolyee({required int index}) => Container(
          child: Text('empolyee $index'),
        );
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              content: GridView.builder(
                  itemCount: 3,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => empolyee(index: index)),
            ));
  }


  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> login(BuildContext context,
      {required String user, password}) async {
    http.Response response = await http.post(Uri.parse(authLogin),
        body: json.encode({"username": user, "password": password}),
        headers: {"Content-Type": "application/json"});
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CupertinoAlertDialog(
                content: CupertinoActivityIndicator(),
              ),
            ));

    if (response.statusCode == 200) {
      Navigator.pop(context);
      Map<String, dynamic> data = json.decode(response.body);
      LoginResponse loginResponse = LoginResponse.fromJson(data);
       print('userKey= ${loginResponse.data!.userKey}');
       print('token = ${loginResponse.data!.token}');
      if (loginResponse.data?.token != null) navigatorOff(context, Home());
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('حدث حطا ما' + ' ' + response.statusCode.toString())));
    }
  }

 static sendSMS({required String phoneNumber,code}){

  TwilioFlutter twilio = TwilioFlutter(
       accountSid : 'ACf8250c669d4270b27b45af8f940c0394', // replace *** with Account SID
       authToken : '6bda4370969cbabea75cdfc61aae5da4',  // replace xxx with Auth Token
       twilioNumber : '+19362593318'  // replace .... with Twilio Number
   );
  //twilioFlutter.sendSMS(toNumber: '+201090039634', messageBody: 'hello');
   twilio.sendSMS(toNumber: '+201090039634', messageBody: code);

 }
  static List<Pages> listPage = [
    Pages(title: 'الرئيسيه', icon: Icons.home_filled, page: HomeBody()),
    Pages(title: 'حسابي', icon: Icons.person, page: UserProFile()),
    Pages(title: 'اعمالي', icon: Icons.monetization_on, page: MyBusiness()),
    Pages(title: 'انشئ مشروعك الخاص', icon: Icons.add, page: AddProject()),
    Pages(title: 'عروض التوظيف', icon: Icons.work, page: MyEmployees())
  ];

  static MaterialColor myColor = const MaterialColor(0xff808080, <int, Color>{
    50: Color(0xff808080),
    100: Color(0xff808080),
    200: Color(0xff808080),
    300: Color(0xff808080),
    400: Color(0xff808080),
    500: Color(0xff808080),
    600: Color(0xff808080),
    700: Color(0xff808080),
    800: Color(0xff808080),
    900: Color(0xff808080),
  });

  static navigatorGo(BuildContext context, Widget route) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));


  void selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
    }
  }

  static navigatorOff(BuildContext context, Widget route) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));

}
