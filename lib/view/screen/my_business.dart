import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/screen/show_employee.dart';
import 'package:toordor/view/widget/TextForm.dart';

class MyBusiness extends StatefulWidget {
  MyBusiness({Key? key}) : super(key: key);

  @override
  State<MyBusiness> createState() => _MyBusinessState();
}

class _MyBusinessState extends State<MyBusiness> {
  TextEditingController business = TextEditingController();
  TextEditingController timer = TextEditingController();

  // String? tryMentType, lengthTryType;
  // Future? userService;
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
  @override
  void initState() {
 //userService = Controller.getServiceEmployee(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  //  Controller.getServiceEmployee(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
   return Scaffold(
        appBar:AppBar2(context:context),
      body:
             SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    height: MySize.height(context) / 2,
                    child: Wrap(
                      children: [
                        Container(
                          // margin: EdgeInsets.all(10),
                          height: h,
                          width: w,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.sp),
                                TextForm(
                                //   icon: Container(),
                                    hint: "نوع الخدمة".tr(), controller: business),
                                TextForm(
                               //   icon: Container(),
                                  hint: 'وقت الخدمة المقدر "دقائق'.tr(),
                                  controller: timer,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          print(business.text);
                                          Controller.createNewService(context,
                                            sevicename: business.text,
                                            duration: timer.text,);
                                        //  Navigator.pop(context);
                                          // Controller.getServiceEmployee(
                                          //     context);
                                          Controller.navigatorGo(context,
                                              const ShowEmployee());

                                        },
                                        child:  Text('متابعة وحفظ'.tr()),
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Controller.createNewService(context,
                                            sevicename: business.text,
                                            duration: timer.text,);
                                          business.clear();
                                          timer.clear();
                                          // Navigator.pop(context);
                                        },
                                        child:  Text('حفظ'.tr()),
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue)),
                                      ),
                                    ],
                                  ),
                                ),




                                // Expanded(
                                //   child: FutureBuilder<dynamic>(
                                //       future: userservice,
                                //       builder: (context, snapshot) {
                                //         if (snapshot.hasData) {
                                //           return ListView.builder(
                                //             itemBuilder: (context, index) {
                                //               var map = snapshot.data?['data'][index];
                                //               print(map);
                                //               trymenttype = map['treatmentType'];
                                //               lengthtrytype = map['trtLenght'].toString();
                                //               return Wrap(
                                //                 children: [
                                //                   Padding(
                                //                     padding: const EdgeInsets.symmetric(
                                //                         horizontal: 10.0, vertical: 20),
                                //                     child: Column(
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment.start,
                                //                       children: [
                                //                         Row(
                                //                           mainAxisAlignment:
                                //                               MainAxisAlignment.start,
                                //                           children: [
                                //                             Padding(
                                //                               padding: EdgeInsets.only(
                                //                                   left: 13.0.sp),
                                //                               child: Text(trymenttype ?? ''),
                                //                             ),
                                //                             Text(
                                //                               lengthtrytype ?? '',
                                //                               style: const TextStyle(
                                //                                   fontSize: 15,
                                //                                   color: Colors.black,
                                //                                   fontWeight:
                                //                                       FontWeight.w700),
                                //                             )
                                //                           ],
                                //                         ),
                                //                         // SizedBox(height: MySize.height(context) / 20),
                                //                         // SizedBox(height: MySize.height(context) / 20),
                                //                       ],
                                //                     ),
                                //                   ),
                                //                 ],
                                //               );
                                //             },
                                //           );
                                //         } else {
                                //           return const Center(
                                //               child: CircularProgressIndicator());
                                //         }
                                //       }),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  //   child: Row(
                  //     children: [
                  //       TextButton(
                  //         onPressed: () {},
                  //         child: Container(
                  //             decoration: BoxDecoration(
                  //                 color: Colors.blue, shape: BoxShape.circle),
                  //             height: 40,
                  //             width: 40,
                  //             child: const Icon(
                  //               Icons.add,
                  //               color: Colors.black,
                  //             )),
                  //       ),
                  //       Text(
                  //         'اضافة خدمه جديدة',
                  //         style: TextStyle(fontSize: 15.sp),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 11),
                ],
              ),
            ));
            //   },
            // );
  }
}
