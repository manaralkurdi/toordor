import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/screen/time_workplace.dart';

class MyWorkPlace extends StatefulWidget {
  const MyWorkPlace({this.userId = '', Key? key}) : super(key: key);

  final String userId;

  @override
  State<MyWorkPlace> createState() => _MyWorkPlaceState();
}

class _MyWorkPlaceState extends State<MyWorkPlace> {
  int indexPage = 0;
  final Connectivity _connectivity = Connectivity();
  bool isLoading = false;
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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar2(context:context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<dynamic>(
          future: Controller.userMessage(context),
          builder: (context,snapshot) {
            if (snapshot.data?['message']!=  "لا يوجد طلبات في لوقت الحالي"){
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 30,
                      width: 105,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue[300],
                      ),
                      child: Text(
                        'الطلبات'.tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?['message'].length??0,
                          itemBuilder: (BuildContext context,index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration:   BoxDecoration(
                                  border:Border.all()

                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Text(
                                              snapshot.data!['message'][index]['businees']['business_name'],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: Text(
                                              snapshot.data!['message'][index]['message'],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                           showAlertDialog2(context,
                                                snapshot.data['message'][index]['id'],
                                               snapshot.data['message'][index]['businees_id']);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 105,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  8),
                                              color: Colors.blue[300],
                                            ),
                                            child: Text(
                                              'موافق'.tr(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            showAlertDialog(context,snapshot.data['message'][index]['id']);
                                         //  Controller.navigatorGo(context, HomeBodyCategory());
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 30,
                                            width: 105,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  8),
                                              color: Colors.blue[300],
                                            ),
                                            child: Text(
                                              'الغاء'.tr(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    //Business name

                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  // Padding(
                  //   padding: const EdgeInsets.all(15.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     children: [
                  //       Container(
                  //         height: 120,
                  //         decoration: BoxDecoration(
                  //           color: Colors.grey,
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             children: [
                  //               //employee name
                  //               // Text(
                  //               //   'yousef',
                  //               //   style: TextStyle(
                  //               //     fontSize: 20,
                  //               //     fontWeight: FontWeight.bold,
                  //               //   ),
                  //               // ),
                  //
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            );
          }
else {
  return Center(child: Text("لا يوجد اي طلبات".tr()));
            }
            }
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context,request_id) {
    // set up the buttons
    Widget remindButton = TextButton(
      child: Text("تاكيد".tr()),
      onPressed:  () {
        Controller.cancelRequestBussnise(context,requestid:request_id);
        Controller.navigatorGo(context, HomeBodyCategory());


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
  showAlertDialog2(BuildContext context,request_id,bussniseID) {

    // set up the buttons
    Widget remindButton = TextButton(
      child: Text("تاكيد".tr()),
      onPressed:  () {
        Controller.AccseptrequestfromBussnise(context,
            requestid:request_id,
           // snapshot.data['message'][index]['id'],
            bussniseID:bussniseID,
            //snapshot.data['message'][index]['businees_id']
        );
        Controller.navigatorGo(context, TimeWorkPlace(
        ));


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
      content: Text("هل انت متأكد من الموافقة على  الطلب".tr()),
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
}
