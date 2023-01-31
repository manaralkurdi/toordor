import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/View/Widget/background.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/view/screen/login_screen.dart';
import 'package:toordor/view/widget/TextForm.dart';
import 'package:toordor/view/widget/constant.dart';
import 'package:toordor/view/widget/text_field.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController password = TextEditingController(),
      rePassword = TextEditingController();

  final Connectivity _connectivity = Connectivity();
  String phone ="";
  bool isLoading = false;
  late SharedPreferences prefs;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
        Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        isLoading = false;
        //     showStatus(result, true);
      });
    } else {
      setState(() {
        //  showStatus(result, false);
        isLoading = true;
      });
    }
  }
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    String translateshared = prefs.getString('StringTranslate') ?? "";
     phone = prefs.getString('phone') ?? "";
    print(phone);
  }
@override
void initState() {
  fetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          floatingActionButton: IconButton(
              icon: const Icon(Icons.arrow_back_ios,color: ColorCustome.coloryellow),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context)=>
                  LoginPage()))
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          body:
          Background(
              items: [
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0,right: 10,left: 12),
                  child:  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TextFormCustome(
                            controller: password,
                            hint: 'كلمة المرور'.tr(),
                            labelText: "يرجى ادخال كلمة المرور".tr()),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom: 16.0),
                        child: TextFormCustome(
                            controller: rePassword,
                            hint: 'تاكيد كلمة المرور'.tr(),
                            labelText: "يرجى ادخال تاكيد كلمة المرور".tr()),
                      ),
                                ElevatedButton(
                                  style:
                                  ElevatedButton.styleFrom(
                                      primary: ColorCustome.colorblue,
                                     // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                    onPressed: (){
                                  setState((){});
                                    Controller.restPassword(context,
                                    confiremPassword: rePassword.text,
                                        password: password.text,phone:phone );
                                    },
                      child: Text('تأكيد'.tr()))
                      // ElevatedButton(
                      //     onPressed: () =>Controller.verifyOTPpassword(context, code: otp.text),
                      //     child:  Text(
                      //       'تأكيد'.tr(),
                      //       style: TextStyle(color: Colors.white),
                      //     ))
                    ],
                  ),
                ),
              ]));
    // Scaffold(
    //   body: SizedBox(
    //     width: MySize.width(context),
    //     height: MySize.height(context),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           SizedBox(height: MySize.height(context)/3),
    //           TextForm(hint: 'كلمة المرور'.tr(),controller: password,),
    //           TextForm(hint: "تاكيد كلمة المرور".tr(),controller: rePassword,),
    //           SizedBox(height: MySize.height(context)/10),
    //           ElevatedButton(onPressed: (){
    //
    //             setState((){});
    //               Controller.restPassword(context,
    //               confiremPassword: rePassword.text,
    //                   password: password.text,phone:phone );
    //               },
    // child: Text('تغيير كلمه المرور'.tr()))
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
