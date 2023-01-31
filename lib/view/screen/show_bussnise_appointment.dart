



import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toordor/view/screen/home_page.dart';

import '../../controller/controller.dart';

class ShowBussniseAppointment extends StatefulWidget {
  const ShowBussniseAppointment({Key? key}) : super(key: key);

  @override
  State<ShowBussniseAppointment> createState() => _ShowBussniseAppointmentState();
}

class _ShowBussniseAppointmentState extends State<ShowBussniseAppointment> {
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
  showAlertDialog(BuildContext context,String id ) {
    // set up the buttons
    Widget remindButton = TextButton(
      child: Text("تاكيد".tr()),
      onPressed:  () {
        setState((){
          Controller.bussnisesCancel(context,id:id);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ShowBussniseAppointment()));
        });

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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("المواعيد".tr(),style: TextStyle(fontSize: 20),),
              Container(
                height: 500,
                child: FutureBuilder<dynamic>(
                    future: Controller.BussniseAppointment(context),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (snapshot.hasData&&snapshot.data['message']!="there is no appointment for your bussines yet") {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: snapshot.data['data']?.length??0,
                              itemBuilder: (context,index) {
                                print("=======================");
                               // print(snapshot.data?['message'][index]['comments']??"" );
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                        border: Border.all()
                                    ),
                                    child: Column(
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("الى:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),

                                            Text(snapshot.data?['data'][index]['from_date'] ?? ''),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("من:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),

                                            Text(snapshot.data?['data'][index]['to_date']?? ""),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("التاريخ:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),

                                            Text(snapshot.data?['data'][index]['date_day']?? ""),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("اسم الخدمة:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(
                                                snapshot.data?['data']==null|| snapshot.data?['data'][index]['service']['name']==null?""
                                           : snapshot.data['data'][index]['service']['name']),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("اسم المستخدم:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(
                                                snapshot.data?['data']==null|| snapshot.data?['data'][index]['user']['name']==null?""
                                                    : snapshot.data['data'][index]['user']['name']),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("رقم الهاتف:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),

                                            Text(
                                                snapshot.data?['data'][index]['user']==null?"":
                                                snapshot.data?['data'][index]['user']['phone']?? ""),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("العامل:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),

                                            Text(snapshot.data?['data'][index]['employee']['name']?? ""),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("هاتف العامل:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),

                                            Text(snapshot.data?['data'][index]['employee']['phone']?? ""),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("ملاحظات:".tr(),style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(snapshot.data?['data'][index]['comments'] ?? ''),

                                          ],
                                        ),
                                        InkWell(
                                          onTap: (){
                                            showAlertDialog(context,snapshot.data['data'][index]['id'].toString());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(children: [
                                              Container(
                                                decoration:BoxDecoration(
                                                border: Border.all(
                                                ),
                                                  color: Colors.grey
                                            ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3.0),
                                                  child: Text("الغاء الموعد".tr()),
                                                ),
                                              )
                                            ],),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                        );
                      }
                      else if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }

                      else {
                       return Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Center(child: Text("لايوجد اي مواعيد".tr())),
                           ),
                         ],
                       );
                      }
                    })
              ),
            ],
          ),
        ),
      ),
    );
  }
}
