


import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/view/screen/home_page.dart';

class AppointmentEmployee extends StatefulWidget {
  const AppointmentEmployee({Key? key}) : super(key: key);

  @override
  State<AppointmentEmployee> createState() => _AppointmentEmployeeState();
}

class _AppointmentEmployeeState extends State<AppointmentEmployee> {
  late SharedPreferences prefs;
   int employee_id = -1;
  fetch() async {
     await Controller.userData(context);
    prefs = await SharedPreferences.getInstance();
    employee_id = prefs.getInt('employee_id') ?? -1;
    print("Controller.userData(context);");
    print(employee_id);
  }
  @override
  void initState() {

    fetch();
  //  Controller.employeeApointement(context,employeeid:employee_id);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return   Scaffold(
      appBar:AppBar2(context:context),
      body: Column(
        children: [
         FutureBuilder<dynamic>(
           future: Controller.userData(context),
            builder: (context,userdata) {

if (userdata.hasData&&userdata.data['message']!=null){
  int employeeid=userdata.data?['message']['employee_id']??-1;
  return FutureBuilder<dynamic>(
      future: Controller.employeeApointement(context,employeeid:employeeid),
      builder: (BuildContext context,snapshot){
        if(snapshot.hasData&&snapshot.data['data']!=null&&userdata.data['message']!=null){
          return Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: snapshot.data['data']?.length??0,
                itemBuilder: (context,index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all()
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("ملاحظات:".tr()),
                                Text(snapshot.data?['data'][index]['comments'] ?? ''),
                              ],
                            ),
                            Row(
                              children: [
                                Text("اسم المستخدم:".tr()),
                                Text(snapshot.data?['data'][index]['user']['name'] ?? ''),
                              ],
                            ),
                            Row(
                              children: [
                                Text("هاتف المستخدم:".tr()),
                                Text(snapshot.data?['data'][index]['user']['phone'] ?? ''),
                              ],
                            ),
                            Row(
                              children: [
                                Text("من:".tr()),
                                Text(snapshot.data?['data'][index]['from_date'] ?? ''),
                              ],
                            ),
                            Row(
                              children: [
                                Text("الى:".tr()),
                                Text(snapshot.data?['data'][index]['to_date']?? ""),
                              ],
                            ),
                            Row(
                              children: [
                                Text("التاريخ:".tr()),
                                Text(snapshot.data?['data'][index]['date_day']?? ""),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        }

        else if (snapshot.data!=null &&snapshot.data!=[]&&
        snapshot.data['data']==[]&&snapshot.data['data']!=null){
          return  Center(child: Container(
              child: Text("لايوجد اي مواعيد".tr())));
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        else{
          // print("failed");
          // Text("gggg");
          return  Center(child: Container(
              child: Text("لايوجد اي مواعيد".tr())),);
        }
      }
  );
}
else if(userdata.connectionState==ConnectionState.waiting){
  return Center(child: CircularProgressIndicator());
}
          else {
  return  Center(child: Container(
      child: Text("لايوجد اي مواعيد".tr())));
}
            }
          )
        ],
      ),
    );
  }
}
