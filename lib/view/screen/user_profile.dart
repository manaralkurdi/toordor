import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/View/Screen/home.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/view/block/cubit/home_cubit.dart';
import 'package:toordor/view/block/state/home_state.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/home_page.dart';
// import 'package:toordor/view/cubit/home_cubit.dart';
// import 'package:toordor/view/cubit/home_state.dart';

import '../../Controller/controller.dart';

class UserProFile extends StatefulWidget {
  UserProFile({Key? key}) : super(key: key);

  @override
  State<UserProFile> createState() => _UserProFileState();
}

class _UserProFileState extends State<UserProFile> {
  bool  isLoading =false;
  final Connectivity _connectivity = Connectivity();
  TextEditingController message = new TextEditingController();
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
  @override
  void initState() {
    Controller.userData(context);
    // TODO: implement initState
    super.initState();
  }
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget remindButton = TextButton(
      child: Text("تاكيد".tr()),
      onPressed:  () {
        Controller.deleteAccount(context);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("الغاء".tr()),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("هل انت متأكد من الغاء الطلب".tr()),
      actions: [
        remindButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar:AppBar2(context:context),
      body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return RefreshIndicator(
                  onRefresh: () async {
                    await Controller.userData(context);
                  },
                  child:  FutureBuilder<dynamic>(
                      future: Controller.userData(context),
                      builder: (context, snapshot) {
                       // context.read<HomeCubit>().getLocation();
                          return SingleChildScrollView(
                            child: Material(
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            // Padding(
                                            //   padding: EdgeInsets.only(left: 13.0.sp),
                                            //   child: CircleAvatar(
                                            //     backgroundColor: Colors.grey,
                                            //     child: const Text(""),
                                            //     radius: 30.sp,
                                            //   ),
                                            // ),
                                            Text(
                                              snapshot.data?['message']['fullname'] ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: MySize.height(context) / 20),
                                        UserDataForm(
                                          title: 'الاسم بالكامل'.tr(),
                                          userData:
                                          snapshot.data?['message']['fullname'] ?? "",
                                        ),
                                        UserDataForm(
                                          title: 'رقم الهاتف'.tr(),
                                          userData:
                                          snapshot.data?['message']['phone'] ?? "",
                                        ),
                                        UserDataForm(
                                            title: 'اسم المستخدم:'.tr(),
                                            userData: snapshot.data?['message']
                                            ['email']),
                                        // UserDataForm(
                                        //   title: 'المدينة'.tr(),
                                        //   userData: cubit.address ?? "",
                                        // ),
                                        // UserDataForm(
                                        //   title: 'الدولة'.tr(),
                                        //   userData: cubit.address2 ?? "",
                                        // ),
                                        SizedBox(height: MySize.height(context) / 20),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              // ElevatedButton(
                                              //     onPressed: () {},
                                              //     child:  Text('حفظ'.tr())),
                                              ElevatedButton(
                                                  onPressed: () {
                              print("--------------------------");
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditUserData(
                        fullName: snapshot
                                .data?['message']['fullname'],
                        phone: snapshot
                                .data?['message']
                        ['phone'],
                        email: snapshot
                                .data?['message']['username'],
                        country: snapshot.data?['message']['country_id'],
                        city: snapshot.data?['message']
                        ['city_id'],
                        )),);
                        },

                                                  child: Text('تعديل'.tr())),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Controller.navigatorOff(
                                                      context, HomeBodyCategory());
                                                },
                                                child: Text('الغاء'.tr()),
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            showAlertDialog(context);
                                          },
                                            child: Row(
                                              children: [
                                                Container(
                                                    decoration:BoxDecoration(
                                                        border: Border.all(
                                                        ),
                                                        color: Colors.grey
                                                    ),
                                                    child: Text("حذف الحساب".tr())),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
      ),
                );


          }),
    );

  }
   // // return BlocConsumer<HomeCubit, HomeState>(
   //    listener: (context, state) {
   //      // TODO: implement listener
   //    },
   //    builder: (context, state) {
   //      var cubit = HomeCubit.get(context);
   //      return Scaffold(
   //        body: RefreshIndicator(
   //          onRefresh: () async {
   //            await Controller.userData(context);
   //          },
   //          child: FutureBuilder<dynamic>(
   //              future: Controller.userData(context),
   //              builder: (context, snapshot) {
   //                if (snapshot.hasData) {
   //                  return Wrap(
   //                    children: [
   //                      Padding(
   //                        padding: const EdgeInsets.symmetric(
   //                            horizontal: 10.0, vertical: 20),
   //                        child: Column(
   //                          mainAxisAlignment: MainAxisAlignment.start,
   //                          children: [
   //                            Row(
   //                              mainAxisAlignment: MainAxisAlignment.start,
   //                              children: [
   //                                // Padding(
   //                                //   padding: EdgeInsets.only(left: 13.0.sp),
   //                                //   child: CircleAvatar(
   //                                //     backgroundColor: Colors.grey,
   //                                //     child: const Text(""),
   //                                //     radius: 30.sp,
   //                                //   ),
   //                                // ),
   //                                Text(
   //                                  snapshot.data?['message']['fullname'] ?? "",
   //                                  style: const TextStyle(
   //                                      fontSize: 15,
   //                                      color: Colors.black,
   //                                      fontWeight: FontWeight.w700),
   //                                )
   //                              ],
   //                            ),
   //                            SizedBox(height: MySize.height(context) / 20),
   //                            UserDataForm(
   //                              title: 'الاسم بالكامل'.tr(),
   //                              userData:
   //                                  snapshot.data?['message']['fullname'] ?? "",
   //                            ),
   //                            UserDataForm(
   //                              title: 'رقم الهاتف'.tr(),
   //                              userData:
   //                                  snapshot.data?['message']['phone'] ?? "",
   //                            ),
   //                            UserDataForm(
   //                                title: 'اسم المستخدم'.tr(),
   //                                userData: snapshot.data?['message']
   //                                    ['username']),
   //                            UserDataForm(
   //                              title: 'المدينة'.tr(),
   //                              userData: cubit.address ?? "",
   //                            ),
   //                            UserDataForm(
   //                              title: 'الدولة'.tr(),
   //                              userData: cubit.address ?? "",
   //                            ),
   //                            SizedBox(height: MySize.height(context) / 20),
   //                            Padding(
   //                              padding: const EdgeInsets.all(8),
   //                              child: Row(
   //                                mainAxisAlignment:
   //                                    MainAxisAlignment.spaceAround,
   //                                children: [
   //                                  // ElevatedButton(
   //                                  //     onPressed: () {},
   //                                  //     child:  Text('حفظ'.tr())),
   //                                  ElevatedButton(
   //                                      onPressed: () => Controller.navigatorGo(
   //                                          context,
   //                                          EditUserData(
   //                                            fullName: snapshot
   //                                                .data?['message']['fullname'],
   //                                            phone: snapshot.data?['message']
   //                                                ['phone'],
   //                                            email: snapshot.data?['message']
   //                                                ['username'],
   //                                            country: snapshot.data?['message']
   //                                                ['country_id'],
   //                                            city: snapshot.data?['message']
   //                                                ['city_id'],
   //                                          )),
   //                                      child:  Text('تعديل'.tr())),
   //                                  ElevatedButton(
   //                                    onPressed: () {
   //                                      Controller.navigatorOff(context, HomeBodyCategory());},
   //                                    child:  Text('الغاء'.tr()),
   //                                  ),
   //                                ],
   //                              ),
   //                            )
   //                          ],
   //                        ),
   //                      ),
   //                    ],
   //                  );
   //                } else {
   //                  return const Center(child: CircularProgressIndicator());
   //                }
   //              }),
   //        ),
   //      );
  }

class UserDataForm extends StatelessWidget {
  UserDataForm({Key? key, this.title, this.userData}) : super(key: key);
  String? title;
  String? userData;

  @override
  Widget build(BuildContext context) {
    return Material(
    child:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
            SizedBox(width: 2.w),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                userData ?? '',
                style: TextStyle(fontSize: 13.sp),
                // textDirection: TextDirection.rtl,
                //textAlign: TextAlign.end,
              ),
            )
          ],
        ),
    ));
  }
}

class EditUserData extends StatelessWidget {
  EditUserData(
      {Key? key,
      this.fullName,
      this.phone,
      this.email,
      this.city,
      this.country})
      : super(key: key);
  final String? fullName, phone, email, city, country;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  late SharedPreferences prefs;

 void addData() {
    controller1.text = fullName ?? '';
    controller2.text = phone ?? '';
    controller3.text = email ?? '';
    controller4.text = city ?? '';
    controller5.text = country ?? '';
  }
  fetch(String controller) async {
    prefs = await SharedPreferences.getInstance();
    dynamic bussniseShared = prefs.setString('fullname',controller) ?? "";
    print(bussniseShared);
  }
  @override
  Widget build(BuildContext context) {
    addData();
    return Scaffold(
        appBar: AppBar2(context: context,),
        body: SingleChildScrollView(
          child: Material(
            child: Column(children: [
              TextForm(hint: 'الاسم'.tr(), controller: controller1),
              TextForm(hint: 'رقم الهاتف'.tr(), controller: controller2),
              TextForm(hint: 'اسم المستخدم'.tr(), controller: controller3),
          //    TextForm(hint: 'المدينة'.tr(), controller: controller4),
            //  TextForm(hint: 'الدولة'.tr(), controller: controller5),
              ElevatedButton(
                child: Text("حفظ التعديلات ".tr()),
                onPressed: () {
                  Controller.userDataEdit(
                    context,
                    phone: controller2,
                    city: controller4,
                    country: controller5,
                    name: controller3,
                    fulname: controller1,
                  );
                  fetch(controller1.text.toString());
                  Controller.navigatorOff(context, HomeBodyCategory());
                }

              ),
            ]),
          ),
        ));
  }
}
