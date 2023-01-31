import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pdfx/pdfx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/View/Widget/headerbacground.dart';
import 'package:toordor/const/color.dart';
import 'package:toordor/const/components.dart';
import 'package:toordor/view/block/cubit_local/locale_cubit.dart';
import 'package:toordor/view/screen/chang_password.dart';
import 'package:toordor/view/screen/facebook.dart';

import 'package:toordor/view/screen/pdf.dart';
import 'package:toordor/view/widget/TextForm.dart';
import 'package:toordor/view/widget/constant.dart';
import 'package:toordor/view/widget/text_field.dart';
import 'dart:ui' as ui;
import 'create_account.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity _connectivity = Connectivity();
  bool isLoading = false;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController name = TextEditingController();

  TextEditingController phoneNumber2 = TextEditingController();

  TextEditingController password2 = TextEditingController();

  TextEditingController Fullname = TextEditingController();
  Controller controller = Controller();
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  final _formKey = GlobalKey<FormState>();
  bool value = true;
  String services = "";
  bool clicklogin = true;
  bool clickregister = false;
  late SharedPreferences prefs;
  String translate = "";
  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('StringTranslate', translate);
    prefs.setString('phone', phoneNumber.text.toString());
  }
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  Future<User?> facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      // try {
      //   final result = (await FacebookAuth.instance.login()).accessToken;
      //   print('result: $result');
      //   if (result == null) return null;
      //   final facebookAuthCredential =
      //   FacebookAuthProvider.credential(result.token);
      //   final user =
      //       (await _auth.signInWithCredential(facebookAuthCredential)).user;
      //   return user;
      // } catch (e) {
      //   print('[FACEBOOK][ERROR: $e]');
      //   return null;
      // }
    }
    else {
      print(result.status);
      print(result.message);
    }
  }
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    String translateshared = prefs.getString('StringTranslate') ?? "";
    String phone = prefs.getString('phone') ?? "";
    print(phone);
  }

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

  Widget register() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormCustome(
                  controller: Fullname,
                  hint: 'الاسم بالكامل'.tr(),
                  labelText: "يرجى ادخال الاسم بالكامل".tr()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormCustome(
                  controller: name,
                  hint: 'اسم المستخدم'.tr(),
                  labelText: "يرجى ادخال اسم المستخدم".tr()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormCustome(
                  controller: phoneNumber2,
                  hint: "رقم الهاتف".tr(),
                  labelText: "يرجى ادخال رقم الهاتف".tr()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormCustome(
                  widget: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorCustome.coloryellow,
                      size: 20,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible2 = !_passwordVisible2;
                        _obscureText2 = !_obscureText2;
                      });
                    },
                  ),
                  controller: password2,
                  keyBoardType: TextInputType.visiblePassword,
                  visibility: _obscureText2,
                  hint: "كلمة المرور".tr(),
                  labelText: "يرجى ادخال كلمة المرور".tr()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: this.value,
                          onChanged: (value) {
                            setState(() {
                              this.value = value!;
                              print(value);
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                ""
                                        "من خلال انضمامك ، فإنك توافق على"
                                    .tr(),
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const pdf()));
                                },
                                child: Text(
                                  "شروط الخدمة".tr(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: ColorCustome.colorblue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const pdf()));
                                },
                                child: Text(
                                  "وسياسة الخصوصية".tr(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: ColorCustome.colorblue,
                                  ),
                                ),
                              ),
                              Text("بما في ذلك استخدام".tr(),
                                  style: TextStyle(fontSize: 10)),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const pdf()));
                                  },
                                  child: Text("ملفات تعريف الارتباط.".tr(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: ColorCustome.colorblue,
                                      )))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DefaultButton(
                    controll: () async {
                      if (phoneNumber2.text.isEmpty || password2.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('يرجى كتابة كافة المعلومات'.tr())));
                      } else {
                        save();
                        print(phoneNumber2.text.toString());
                        value == true
                            ? Controller.sendOTP(
                                context,
                                phone: phoneNumber2.text.toString(),
                                // password: password.text.toString(),
                                // fullname: name.text.toString(),
                                // userName: userName.text.toString()
                              )
                            : ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'يرجى الموافقة على سياسة الخصوصية'
                                            .tr())));
                      }

                      //     await Controller.sendOTP(context, phone: phoneNumber.text);
                    },
                    text: 'تسجيل الحساب'.tr()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget login() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormCustome(
                    controller: phoneNumber,
                    hint: "رقم الهاتف".tr(),
                    labelText: "يرجى ادخال رقم الهاتف".tr()),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormCustome(
                  hint: "كلمة المرور".tr(),
                  labelText: "يرجى ادخال كلمة المرور".tr(),
                  keyBoardType: TextInputType.visiblePassword,
                  visibility: _obscureText,
                  controller: password,
                  widget: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorCustome.coloryellow,
                      size: 20,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (phoneNumber.text.isEmpty) {
                            var snackBar = SnackBar(
                                content: Text(
                                    "يجب عليك كتابة رقم الهاتف اولا".tr()));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            save();
                            fetch();
                            print(phoneNumber.text.toString());
                           // Controller.navigatorOff(context, ChangePassword());
                            Controller.sendOTPpassword(context,
                                phone: phoneNumber.text.toString());
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            "هل نسيت كلمة المرور الخاصة بك ؟".tr(),
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          Text(
                            "انقر هنا ".tr(),
                            style: TextStyle(
                              color: ColorCustome.colorblue,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DefaultButton(
                      controll: () async {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            controller.login(context,
                                phone: phoneNumber.text,
                                password: password.text);
                          } else if (password.text.isEmpty ||
                              phoneNumber.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'يرجى التاكد من كتابة اسم المستخدم وكلمة المرور'
                                      .tr()),
                              duration: Duration(seconds: 2),
                              margin: EdgeInsets.all(10),
                            ));
                          } else {
                            print("0000");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('يرجى التاكد من المعلومات'.tr())));
                          }
                          FocusManager.instance.primaryFocus!.unfocus();
                        });
                        //   print(data['message']['has_bussinees'].toString());
                      },
                      text: 'تسجيل الدخول'.tr()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12,top: 9),
                      child: Container(
                        child: Text("او تسجيل دخول عبر",style: TextStyle(color: ColorCustome.coloryellow),),
                      ),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Container(
                              child: Image.asset("assets/gmail.png",height: 40,),
                            ),
                          ),
                          InkWell(
                            onTap: ()  {
                           //  _requestPermission();
                              facebookLogin();
                              // Navigator.pushReplacement(context,
                              //     MaterialPageRoute(builder: (context) => FacebookApp()));
                            },
                            child: Container(
                              child: Image.asset("assets/facebook.png",height: 40,),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _requestPermission() async {
    final status = await Permission.storage.request();
    print(status);
  }
  String userEmail = "";
  // Future<User?> signInWithFacebook() async {
  //   try {
  //     final result = (await FacebookAuth.instance.login()).accessToken;
  //     print('result: $result');
  //     if (result == null) return null;
  //     final facebookAuthCredential =
  //     FacebookAuthProvider.credential(result.token);
  //     final usrCredential =
  //         (await _auth.signInWithCredential(facebookAuthCredential)).user;
  //     return usrCredential;
  //   } catch (e) {
  //     print('[FACEBOOK][ERROR: $e]');
  //     return null;
  //   }
  // }

  bool _checking = true;
  Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      _checking = false;
    });
    if (accessToken != null) {
      print("is Logged:::: ${(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    }
  }

  Future<void> _login() async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }

    setState(() {
      _checking = false;
    });
  }


  void _printCredentials() {
    print(
      _accessToken!.toJson(),
    );
  }
  @override
  void initState() {
    initConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    //_connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Container(
          margin: EdgeInsets.only(left: 12, right: 12, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    child: Image.asset(
                      'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                !_checking
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    :    SingleChildScrollView(
                    child: BlocBuilder<LocaleCubit, ChangeLanguageState>(
  builder: (context, state) {
    return Column(
                      children: [
                        ClipPath(
                          clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          ),
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                              color: Colors.white,
                             borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight:Radius.circular(5) )
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    //  <--- top
                                    color: ColorCustome.colorblue,
                                    width: 8.0,

                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 17.0,
                                  right: 17,
                                  top: 12,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 20,
                                          child: Image.asset("assets/world.png"),
                                        ),
                                        // OutlinedButton(
                                        //   onPressed: () async {
                                        //     translate=state.locale.languageCode;
                                        //     prefs = await SharedPreferences.getInstance();
                                        //     prefs.setString('StringTranslate', translate);
                                        //     print(prefs.getString('StringTranslate'));
                                        //    // print(i.languageCode);
                                        //     state.locale.languageCode=="he"?
                                        //     context.read<LocaleCubit>().changeLanguage("ar"): context.read<LocaleCubit>().changeLanguage("he");
                                        //     translator.setNewLanguage(
                                        //       context,
                                        //       newLanguage:state.locale.toString(),
                                        //       remember: true,
                                        //       restart: false,
                                        //     );
                                        //   },
                                        //   child: Text(state.locale.languageCode),
                                        // ),
                                        InkWell(
                                          onTap: (){
                                            setState(()  {
                                              translate=state.locale.languageCode;
                                              // prefs = await SharedPreferences.getInstance();
                                              // prefs.setString('StringTranslate', translate);
                                              // print(prefs.getString('StringTranslate'));
                                              // print(i.languageCode);
                                              state.locale.languageCode=="he"?
                                              context.read<LocaleCubit>().changeLanguage("ar"): context.read<LocaleCubit>().changeLanguage("he");
                                              translator.setNewLanguage(
                                                context,
                                                newLanguage:state.locale.languageCode,
                                                remember: true,
                                                restart: false,
                                              );
                                            });

                                          },
                                          child: Container(
                                            child: Text(state.locale.languageCode=="he"?"اللغة العبرية":"اللغة العربية",style: TextStyle(fontSize: 15,color: Colors.black),),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20.0,top: 30),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                print("gyiyfyi");
                                                clicklogin = true;
                                                clickregister = false;
                                                print(clickregister);
                                                print(clicklogin);
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "تسجيل الدخول".tr(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                clicklogin == true
                                                    ? Container(
                                                        color: ColorCustome.coloryellow,
                                                        width: 108,
                                                        height: 4,
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                print("clickregister");
                                                clickregister = true;
                                                clicklogin = false;
                                                print(clickregister);
                                                print(clicklogin);
                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Text("انشاء حساب".tr(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold)),
                                                ),
                                                clicklogin == false
                                                    ? Container(
                                                        color: ColorCustome.coloryellow,
                                                        width: 108,
                                                        height: 4,
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    clicklogin == true ? login() : register()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
  },
),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    //     Scaffold(
    //   backgroundColor: selectBackGround,
    //   body: DoubleBackToCloseApp(
    //     snackBar:
    //     SnackBar(content: Text('انقر مره اخرى للخروج'.tr())),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Container(
    //             height: _headerHeight,
    //             child: HeaderWidget(
    //               _headerHeight,
    //               true,
    //               Image.asset(
    //                   'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
    //             ),
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: translator.locals().map((i) {
    //               return Column(
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: OutlinedButton(
    //                       onPressed: () async {
    //                         translate=i.languageCode;
    //                         prefs = await SharedPreferences.getInstance();
    //                         prefs.setString('StringTranslate', translate);
    //                         print(prefs.getString('StringTranslate'));
    //                         print( i.languageCode);
    //                         context.read<LocaleCubit>().changeLanguage(i.languageCode);
    //                         translator.setNewLanguage(
    //                           context,
    //                           newLanguage: i.languageCode,
    //                           remember: true,
    //                           restart: false,
    //                         );
    //                       },
    //                       child: Text(i.languageCode),
    //                     ),
    //                   ),
    //                 ],
    //               );
    //             }).toList(),
    //           ),
    //           SafeArea(
    //             child: Container(
    //               padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    //               //  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
    //               child: Form(
    //                 key: _formKey,
    //                 child: Column(
    //                   children: [
    //
    //                      Text(
    //                       'تسجيل الدخول'.tr(),
    //                       style: TextStyle(
    //                         fontSize: 30,
    //                         color: Colors.grey
    //
    //                       ),
    //                     ),
    //                     TextForm(
    //                       controller: email,
    //                       keyBoardType: TextInputType.phone,
    //                       widget: null,
    //                       hint: 'رقم الهاتف'.tr(),
    //                     ),
    //                     const SizedBox(height: 7),
    //         Container(
    //           height: 40,
    //           width: MediaQuery.of(context).size.width,
    //           decoration: BoxDecoration(
    //               border: Border.all(width: 0),
    //               borderRadius: BorderRadius.circular(12),
    //               color: Colors.grey.shade100),
    //           margin: const EdgeInsets.symmetric(vertical:12,horizontal: 20),
    //           padding: const EdgeInsets.symmetric( vertical:3,),
    //           child: TextFormField(
    //             keyboardType: TextInputType.visiblePassword ,
    //             obscureText:  _obscureText,
    //             controller: password,
    //             decoration: InputDecoration(
    //               suffixIcon: IconButton(
    //             icon: Icon(
    //             // Based on passwordVisible state choose the icon
    //             _passwordVisible
    //             ? Icons.visibility
    //               : Icons.visibility_off,
    //               color: Theme.of(context).primaryColorDark,
    //             ),
    //             onPressed: () {
    //               // Update the state i.e. toogle the state of passwordVisible variable
    //               setState(() {
    //                 _passwordVisible = !_passwordVisible;
    //                 _obscureText=!_obscureText;
    //               });
    //             },
    //               ),
    //               contentPadding: EdgeInsets.only(right: 8,bottom: 10),
    //               hintText: "كلمة المرور".tr(),
    //               hintStyle: const TextStyle(fontSize: 12),
    //               border: InputBorder.none,
    //             ),
    //
    //           ),
    //         ),
    //                     // TextForm(
    //                     //   controller: password,
    //                     //   visibility: true,
    //                     //   keyBoardType: TextInputType.visiblePassword,
    //                     //   widget:null,
    //                     //   hint: 'كلمة المرور'.tr(),
    //                     //
    //                     // ),
    //                     // TextForm(
    //                     //     hint: 'كلمه المرور',
    //                     //     controller: password,
    //                     //     visibility: true),
    //                     const SizedBox(height: 7),
    //
    //                     Container(
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             child: Checkbox(
    //                               value: this.value,
    //                               onChanged: ( value) {
    //                                 setState(() {
    //                                   this.value = value!;
    //                                   print(value);
    //                                 });
    //                               },
    //                             ),
    //                           ),
    //                           Container(
    //                             child: Column(
    //                               children: [
    //                                  Row(
    //                                    children: [
    //                                      Text(""
    //                                         "من خلال انضمامك ، فإنك توافق على".tr()
    //                                      ,style: TextStyle(fontSize: 10,),),
    //                                      InkWell(
    //                                        onTap: (){
    //                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const pdf()));
    //                                        },
    //                                        child: Text(
    //                                          "شروط الخدمة".tr()
    //                                          ,style: TextStyle(fontSize: 10,color: Colors.blue),),
    //                                      ),
    //
    //
    //                                    ],
    //                                  ),
    //                                 Row(
    //                                   children: [
    //                                     InkWell(
    //                                       onTap: (){
    //                                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const pdf()));
    //
    //                                       },
    //                                       child: Text("وسياسة الخصوصية".tr()
    //                                         ,style: TextStyle(fontSize: 10,color: Colors.blue),),
    //                                     ),
    //                                     Text("بما في ذلك استخدام".tr(),style: TextStyle(fontSize: 10)),
    //                                     InkWell(
    //                                       onTap: (){
    //                                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const pdf()));
    //                                       },
    //                                         child: Text("ملفات تعريف الارتباط.".tr(),style: TextStyle(fontSize: 10,color: Colors.blue)))
    //                                   ],
    //                                 ),
    //
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     Container(
    //                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
    //                       alignment: Alignment.topRight,
    //                       child: GestureDetector(
    //                         onTap: (){
    //                           if (email.text.isEmpty){
    //                             var snackBar = SnackBar(content: Text("يجب عليك كتابة رقم الهاتف اولا".tr()));
    //                             ScaffoldMessenger.of(context).showSnackBar(
    //                                 snackBar);
    //                           }
    //                           else{
    //                             save();
    //                             fetch();
    //                             print(email.text.toString());
    //                          Controller.sendOTPpassword(context, phone: email.text.toString());
    //                           }
    //
    //                         },
    //                         child:  Row(
    //                           children: [
    //                             Text(
    //                               "هل نسيت كلمة المرور الخاصة بك ؟".tr(),
    //                               style: TextStyle(
    //                                 color: Colors.grey,
    //                               ),
    //                             ),
    //                             Text(
    //                               "انقر هنا ".tr(),
    //                               style: TextStyle(
    //                                 color: Colors.blue,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     DefaultButton(
    //                         controll: () async {
    //
    //                      //   print(data['message']['has_bussinees'].toString());
    //                           if (_formKey.currentState!.validate()) {
    //
    //                             value == true ?
    //                             controller.login(context,
    //                                 phone: email.text,
    //                                 password: password.text)
    //                                 :
    //                             ScaffoldMessenger.of(context).showSnackBar(
    //                                  SnackBar(content: Text('يرجى الموافقة على سياسة الخصوصية'.tr())));
    //                           }
    //                           else if (password.text.isEmpty||email.text.isEmpty){
    //                             ScaffoldMessenger.of(context).showSnackBar(
    //                                 SnackBar(content:
    //                                 Text('يرجى التاكد من كتابة اسم المستخدم وكلمة المرور'.tr()),
    //                                   duration: Duration(seconds: 2),margin: EdgeInsets.all(10),));
    //                           }
    //
    //                           else{
    //                             print("0000");
    //                             ScaffoldMessenger.of(context).showSnackBar(
    //                                  SnackBar(content: Text('يرجى التاكد من المعلومات'.tr())));
    //                           }
    //                           FocusManager.instance.primaryFocus!.unfocus();
    //                         },
    //                         text: 'تسجيل الدخول'.tr()),
    //                     // ElevatedButton(
    //
    //                     //   onPressed: () async {
    //                     //     //  print(snapshot.data.toString()+"bkhvjdkc") ;
    //                     //     // controller.fetchAllUsers(context, email.text);
    //                     //     controller.login(context,
    //                     //         phone: email.text, password: password.text);
    //                     //   },
    //                     //   // controller.login(context, user: email.text, password: password.text),
    //                     //   child: const Text(
    //                     //     'تسجيل الدخول',
    //                     //     style: TextStyle(color: Colors.white),
    //                     //   ),
    //                     // ),
    //                     Container(
    //                       margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
    //                       //child: Text('Don\'t have an account? Create'),
    //                       child: Text.rich(TextSpan(children: [
    //                          TextSpan(text: "ليس لديك حساب؟".tr(), style: TextStyle(
    //                            color: Colors.grey,
    //                          ),),
    //                         TextSpan(
    //                           text: 'انشاء حساب'.tr(),
    //                           recognizer: TapGestureRecognizer()
    //                             ..onTap = () {
    //                               Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) => SignUP()));
    //                             },
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.blue),
    //                         ),
    //                       ])),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
