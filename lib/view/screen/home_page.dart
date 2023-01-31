import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/home.dart';
import 'package:toordor/view/screen/add_project.dart';
import 'package:toordor/view/screen/appointment_employee.dart';
import 'package:toordor/view/screen/bussnise_profile.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/logout_screen.dart';
import 'package:toordor/view/screen/my_business.dart';
import 'package:toordor/view/screen/my_employees.dart';
import 'package:toordor/view/screen/my_work_place.dart';
import 'package:toordor/view/screen/setting.dart';
import 'package:toordor/view/screen/show_bussnise_appointment.dart';
import 'package:toordor/view/screen/show_employee.dart';
import 'package:toordor/view/screen/time_workplace.dart';
import 'package:toordor/view/screen/user_profile.dart';

class AppBar2 extends StatefulWidget implements PreferredSizeWidget {
  BuildContext context;
  AppBar2({Key? key, required this.context}) : super(key: key);

  @override
  State<AppBar2> createState() => _AppBar2State();

  static final _appBar = AppBar();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => _appBar.preferredSize*1.5;
}

class _AppBar2State extends State<AppBar2> {
  final Connectivity _connectivity = Connectivity();
  bool isLoading = false;
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

  late SharedPreferences prefs;
  bool bussniseid = true;
  bool isemployee = true;
  fetch() async {
    prefs = await SharedPreferences.getInstance();

    bussniseid = prefs.getBool('has_bussinees') ?? false;
    isemployee = prefs.getBool('is_employee') ?? false;
    print("bussniseid");
    print(bussniseid);
    print(isemployee);
  }

  @override
  void initState() {fetch();
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
    fetch();
  return SafeArea(
            child: Hero(
            tag: 'tag',
            child: FutureBuilder<dynamic>(
              future: Controller.userData(context),
              builder: (context,snapshot) {
                fetch();
                return Container(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, int) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child:bussniseid==false
                                        ? Material(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    HomeBodyCategory()));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                shape:
                                                                    BoxShape.rectangle,
                                                                color: Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10)),
                                                            child:
                                                                Text('الرئيسية'.tr())),
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    UserProFile()));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Container(
                                                            padding:
                                                                EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                shape:
                                                                    BoxShape.rectangle,
                                                                color: Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10)),
                                                            child: Text('حسابي'.tr())),
                                                      )),
                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      AddProject()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(8.0),
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets.all(10.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors.blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Text(
                                                                  'انشئ مشروعك الخاص'
                                                                      .tr())),
                                                        )),
                                                  ),
                                                isemployee==true?  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TimeWorkPlace(
                                                                      )));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(8.0),
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets.all(10.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors.blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Text(
                                                                  'اوقات العمل'.tr())),
                                                        )),
                                                  ):Material(),
                                                isemployee==true?  Material(
                                                  child: InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                AppointmentEmployee()
                                                            ));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(8.0),
                                                        child: Container(
                                                            padding:
                                                            EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                color: Colors.blue,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10)),
                                                            child: Text(
                                                                'مواعيد المستخدمين'.tr())),
                                                      )),
                                                ):Material(),
                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MyWorkPlace()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                shape:
                                                                    BoxShape.rectangle,
                                                                color: Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10)),
                                                            child: Text(
                                                              'طلبات التوظيف'.tr(),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    SettingPage()));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          padding: EdgeInsets.all(10.0),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.rectangle,
                                                              color: Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      10)),
                                                          child: Text(
                                                            'اعدادات'.tr(),
                                                          ),
                                                        ),
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Logout()));
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          padding: EdgeInsets.all(10.0),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.rectangle,
                                                              color: Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      10)),
                                                          child: Text(
                                                            'تسجيل الخروج'.tr(),
                                                          ),
                                                        ),
                                                      ))
                                                ]),
                                        )
                                        : Material(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ShowBussniseAppointment()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Container(
                                                              padding: EdgeInsets.all(
                                                                  10.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors.blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Text(
                                                                  'الرئيسية'.tr())),
                                                        )),
                                                  ),

                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      BussniseProFile()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Container(
                                                              padding: EdgeInsets.all(
                                                                  10.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors.blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child:
                                                                  Text('حسابي'.tr())),
                                                        )),
                                                  ),
                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MyBusiness()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Container(
                                                              padding: EdgeInsets.all(
                                                                  10.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors.blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Text(
                                                                  'اعمالي'.tr())),
                                                        )),
                                                  ),
                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MyEmployees()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Container(
                                                              padding: EdgeInsets.all(
                                                                  10.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors.blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              child: Text(
                                                                  'عروض التوظيف'
                                                                      .tr())),
                                                        )),
                                                  ),
                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ShowEmployee()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                color: Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Text(
                                                              'الموظفين'.tr(),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      SettingPage()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                color: Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Text(
                                                              'اعدادات'.tr(),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  Material(
                                                    child: InkWell(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Logout()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                color: Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Text(
                                                              'تسجيل الخروج'.tr(),
                                                            ),
                                                          ),
                                                        )),
                                                  )

                                                  //                   else{
                                                  // return   Container();

                                                  //               //
                                                  //               //     // FutureBuilder<dynamic>(
                                                  //               //     //     future: Controller.userData(context),
                                                  //               //     //   builder: (context,snapshot) {
                                                  //               //     //
                                                  //               //     //
                                                  //               //     //   }
                                                  //               //     // ),
                                                  //               //
                                                  //               //
                                                  //               //
                                                  //               //     ///
                                                  //               //     /// bussnise
                                                  //               //
                                                  //               //   ],
                                                  //               // );
                                                  //             }
                                                ]),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }));
              }
            ),
          ))
    ;
    //     SingleChildScrollView(
    //       scrollDirection: Axis.horizontal,
    //       child: Expanded(
    //         child: Flexible(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               InkWell(
    //                   onTap: (){
    // Navigator.pushReplacement(
    // context, MaterialPageRoute(builder: (context) => HomeBodyCategory()));
    // },
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Container(child: Text("الرئيسية")),
    //               )),
    //
    //               InkWell(onTap: (){
    //                 Navigator.pushReplacement(
    //                     context, MaterialPageRoute(builder: (context) => UserProFile()));
    //               },
    //                   child: Text("حسابي")),
    //               InkWell(onTap: (){
    //                 Navigator.pushReplacement(
    //                     context, MaterialPageRoute(builder: (context) => UserProFile()));
    //               },
    //                   child: Text("انشئ مشروعك الخاص")),
    //               InkWell(onTap: (){
    //                 Navigator.pushReplacement(
    //                     context, MaterialPageRoute(builder: (context) => UserProFile()));
    //               },
    //                   child: Text("حسابي")),
    //               InkWell(onTap: (){
    //                 Navigator.pushReplacement(
    //                     context, MaterialPageRoute(builder: (context) => UserProFile()));
    //               },
    //                   child: Text("حسابي")),
    //               InkWell(onTap: (){
    //                 Navigator.pushReplacement(
    //                     context, MaterialPageRoute(builder: (context) => UserProFile()));
    //               },
    //                   child: Text("حسابي")),
    //               InkWell(onTap: (){
    //                 Navigator.pushReplacement(
    //                     context, MaterialPageRoute(builder: (context) => UserProFile()));
    //               },
    //                   child: Text("حسابي")),
    //             ],
    //           ),
    //         ),
    //       ),
    //     )
  }
}
