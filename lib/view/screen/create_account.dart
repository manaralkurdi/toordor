import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/view/screen/login_screen.dart';
import 'package:toordor/view/screen/pdf.dart';
import 'package:toordor/view/widget/background.dart';
import 'package:toordor/view/widget/constant.dart';
import 'package:toordor/view/widget/headerbacground.dart';
import 'package:toordor/const/components.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/view/widget/text_field.dart';
import '../../controller/controller.dart';
import '../widget/TextForm.dart';

class SignUP extends StatefulWidget {
  SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  Controller c = Controller();

  TextEditingController name = TextEditingController();


  TextEditingController phoneNumber = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController Fullname = TextEditingController();

  double _headerHeight = 250;

  Controller controller = Controller();
      bool _passwordVisible = false;
 bool value = true;
   bool _obscureText = true;
 late SharedPreferences prefs;
  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name.text.toString());
    prefs.setString('phoneNumber', phoneNumber.text.toString());
    prefs.setString('password', password.text.toString());
    prefs.setString('Fullname', Fullname.text.toString());
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: SingleChildScrollView(
          child: Wrap(children: [
            Column(
              children: [
                Container(
                  height: _headerHeight,
                  child: HeaderWidget(
                    _headerHeight,
                    true,
                    Container(
                      child: Image.asset(
                          'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
                    ),
                  ),
                ),

                // TextForm(
                //   hint: 'الاسم بالكامل',
                //   controller: name,
                //   keyBoardType: TextInputType.name,
                // ),
                SizedBox(height: MySize.height(context) / 12),
                TextForm(
                  controller: name,
                  keyBoardType: TextInputType.name,
                  hint: 'الاسم بالكامل'.tr(),
                ),

                TextForm(
                  controller: Fullname,
                  keyBoardType: TextInputType.name,
                  hint: 'اسم المستخدم:'.tr(),
                ),

                // TextForm(
                //   hint: 'اسم المستخدم  ',
                //   controller: Fullname,
                //   keyBoardType: TextInputType.name,
                // ),
                /*TextForm(
              hint: 'البريد الالكتروني',
              controller: userName,
              keyBoardType: TextInputType.emailAddress,
            ),
            */

                TextForm(
                  controller: phoneNumber,
                  keyBoardType: TextInputType.phone,
                  hint: 'رقم الهاتف'.tr(),
                ),

                // TextForm(
                //   hint: 'رقم الهاتف',
                //   controller: phoneNumber,
                //   keyBoardType: TextInputType.phone,
                // ),
                // TextForm(
                //     hint: 'كلمه المرور', controller: password, visibility: true),

                TextForm(
                  controller: password,
                  visibility: _obscureText,
                  keyBoardType: TextInputType.visiblePassword,
                  hint: 'كلمة المرور'.tr(),
                  widget:IconButton(
                icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible
                ? Icons.visibility
                  : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
              _obscureText=!_obscureText;
            });
          },
        ),

                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Checkbox(
                          value: this.value,
                          onChanged: ( value) {
                            setState(() {
                              this.value = value!;
                              print(value);
                            });
                          },
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(""
                                    "من خلال انضمامك ، فإنك توافق على".tr()
                                  ,style: TextStyle(fontSize: 10,),),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const pdf()));
                                  },
                                  child: Text(
                                    "شروط الخدمة".tr()
                                    ,style: TextStyle(fontSize: 10,color: Colors.blue),),
                                ),


                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const pdf()));

                                  },
                                  child: Text("وسياسة الخصوصية".tr()
                                    ,style: TextStyle(fontSize: 10,color: Colors.blue),),
                                ),
                                Text("بما في ذلك استخدام".tr(),style: TextStyle(fontSize: 10)),
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const pdf()));

                                  } ,
                                    child: Text("ملفات تعريف الارتباط.".tr(),style: TextStyle(fontSize: 10,color: Colors.blue)))
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MySize.height(context) * 0.02),
                DefaultButton(
                    controll: () async {
                      if (phoneNumber.text.isEmpty||password.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('يرجى كتابة كافة المعلومات'.tr())));
                      }
                      else {
                        save();
                        print(phoneNumber.text.toString());
                        value == true?
                        Controller.sendOTP(context,
                            phone: phoneNumber.text.toString(),
                          // password: password.text.toString(),
                          // fullname: name.text.toString(),
                          // userName: userName.text.toString()
                        )
                            :
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('يرجى الموافقة على سياسة الخصوصية'.tr())));
                      }

                 //     await Controller.sendOTP(context, phone: phoneNumber.text);

                    },
                    text: 'تسجيل الحساب'.tr()),
                // ElevatedButton(
                //     style: ButtonStyle(
                //         //    backgroundColor: MaterialStateProperty.all(Colors.grey.shade400)
                //         ),
                //     child: SizedBox(
                //         width: w / 1.8,
                //         height: h / 20,
                //         child: const Center(
                //             child: Text(
                //           'تسجيل الحساب',
                //           style: TextStyle(color: Colors.white),
                //         ))),
                //     onPressed: () async {
                // controller.register(context,
                //     phone: phoneNumber.text,
                //     password: password.text,
                //     fullName: name.text,
                //     userName: Fullname.text);
                //       // SharedPreferences prefs = await SharedPreferences.getInstance();
                //       // registerapi(name.text.toString(), password.text,Fullname.text.toString(), phoneNumber.text.toString(),
                //       //     "780979842");

                //       //   Controller.navigatorGo(context, OTPScreen(phone: phoneNumber.text));
                //     }),
              ],
            ),
          ]),
        ));

  }
}

class OTPScreen extends StatefulWidget {

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp = TextEditingController();

  String name ="";

  String phoneNumber = "";

  String password = "";

  String Fullname ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Random random =Random();
    // code=random.nextInt(100000).toString();
    //controller.sendSMS(code: code,phoneNumber: number);
  }
  late SharedPreferences prefs;
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    name = (prefs.getString('name') ?? "") ;
    phoneNumber = (prefs.getString('phoneNumber') ?? "") ;
    password = (prefs.getString('password') ?? "") ;
    Fullname = (prefs.getString('Fullname') ?? "");
print(phoneNumber.toString());
  }
  @override
  Widget build(BuildContext context) {
    fetch();
    return
      Scaffold(
          floatingActionButton: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
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
                  child:  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          child: OtpTextField(
                              numberOfFields: 6,
                              fieldWidth: 40,

                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              borderColor: ColorCustome.colorblue,
                              enabledBorderColor:ColorCustome.colorblue,
                              focusedBorderColor:ColorCustome.colorblue ,
                              //set to true to show as box or false to show as dash
                              showFieldAsBox: true,
                              //    disabledBorderColor: Colors.black,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                //handle validation or checks here
                              },
                              onSubmit: (String verificationCode){
                                Controller.verifyOTPpassword(context, code: verificationCode);
                                // showDialog(
                                // context: context,
                                // builder: (context){
                                // return AlertDialog(
                                // title: Text("Verification Code"),
                                // content: Text('Code entered is $verificationCode'),
                                // );
                                // }
                                // // TextFormCustome(
                                // //     controller: otp,
                                // //     hint: "الكود".tr(),
                                // //     labelText: "يرجى ادخال الكود".tr()),
                                // );

                              }),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              Controller.sendOTPpassword(context,
                                  phone: phoneNumber.toString());
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "اعادة ارسال",style: TextStyle(color: ColorCustome.coloryellow,decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        // ElevatedButton(
                        //     onPressed: () =>Controller.verifyOTPpassword(context, code: otp.text),
                        //     child:  Text(
                        //       'تأكيد'.tr(),
                        //       style: TextStyle(color: Colors.white),
                        //     ))
                      ],
                    ),
                  ),
                ),
              ]));
    //   Scaffold(
    //   floatingActionButton: IconButton(
    //     icon: const Icon(Icons.arrow_back_ios),
    //     onPressed: () => Navigator.push(context, MaterialPageRoute(builder:(context)=>
    //         LoginPage())),
    //   ),
    //   floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    //   body:
    // //   Background(
    // //     items: [
    // //       const SizedBox(height: 60),
    // //       TextForm(
    // //           hint: 'كود التاكيد'.tr(),
    // //           controller: otp,
    // //           keyBoardType: TextInputType.phone),
    // //       const SizedBox(height: 20),
    // //       ElevatedButton(
    // //           onPressed: () {
    // //             Controller.verifyOTP(
    // //                 context, code: otp.text,
    // //                 userName: name.toString(),
    // //                 fullname: Fullname.toString(),
    // //                 password: password.toString(),
    // //                 phoneNumber: phoneNumber.toString(),
    // // );
    // //             print(name.toString());
    // //             print(phoneNumber.toString(),);
    // //             },
    // //           child:  Text(
    // //             'تأكيد'.tr(),
    // //             style: TextStyle(color: Colors.white),
    // //           ))
    // //     ],
    // //   ),
    // );
  }
}
class OTPScreenpassword extends StatefulWidget {
  const OTPScreenpassword(
      {Key? key})
      : super(key: key);


  @override
  State<OTPScreenpassword> createState() => _OTPScreenpasswordState();
}

class _OTPScreenpasswordState extends State<OTPScreenpassword> {
  late SharedPreferences prefs;
  String phone="";
  fetch() async {
    prefs = await SharedPreferences.getInstance();
     phone = prefs.getString('phone') ?? "";
    print(phone);
  }
  TextEditingController otp = TextEditingController();


  @override
  void initState() {
    fetch();
    // TODO: implement initState
    super.initState();
    //Random random =Random();
    // code=random.nextInt(100000).toString();
    //controller.sendSMS(code: code,phoneNumber: number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
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
            child:  Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                children: [
                  Container(
                    height: 90,
                    child: OtpTextField(
                      numberOfFields: 6,
fieldWidth: 40,

borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderColor: ColorCustome.colorblue,
                        enabledBorderColor:ColorCustome.colorblue,
                      focusedBorderColor:ColorCustome.colorblue ,
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                //    disabledBorderColor: Colors.black,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
    onSubmit: (String verificationCode){
      Controller.verifyOTPpassword(context, code: verificationCode);
    // showDialog(
    // context: context,
    // builder: (context){
    // return AlertDialog(
    // title: Text("Verification Code"),
    // content: Text('Code entered is $verificationCode'),
    // );
    // }
    // // TextFormCustome(
    // //     controller: otp,
    // //     hint: "الكود".tr(),
    // //     labelText: "يرجى ادخال الكود".tr()),
    // );

    }),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        Controller.sendOTPpassword(context,
                            phone: phone.toString());
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                             child: Text(
                               "اعادة ارسال",style: TextStyle(color: ColorCustome.coloryellow,decoration: TextDecoration.underline),
                             ),
                          ),
                        ],
                      ),
                    ),
                  )
                  // ElevatedButton(
                  //     onPressed: () =>Controller.verifyOTPpassword(context, code: otp.text),
                  //     child:  Text(
                  //       'تأكيد'.tr(),
                  //       style: TextStyle(color: Colors.white),
                  //     ))
                ],
              ),
            ),
          ),
            ]));
  }
}
