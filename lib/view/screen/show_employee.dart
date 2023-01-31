//
//
//
// import 'package:flutter/material.dart';
// import 'package:toordor/controller/controller.dart';
// import 'package:toordor/model/bussnise_employee.dart';
//
// import '../../model/services.dart';
//
// class ShowEmployee extends StatefulWidget {
//   const ShowEmployee({Key? key}) : super(key: key);
//
//   @override
//   State<ShowEmployee> createState() => _ShowEmployeeState();
// }
//
// class _ShowEmployeeState extends State<ShowEmployee> {
//   bool showappointment=false;
//   @override
//   Widget build(BuildContext context) {
//     return
//       Column(
//         children: [
//           Expanded(
//             child: FutureBuilder<List<BussniseEmployes>>(
//             future: Controller.BussniseEmployee(context,),
//             builder: (context,snapshot) {
//               return Container(
//                 child:  ListView.builder(
//                   itemCount: snapshot.data?.length,
//                     itemBuilder: (BuildContext context, int index) {
//                     return  Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SingleChildScrollView(
//                         child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all()
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text("اسم الموظف :"),
//                                     ),
//                                     Text(""),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(" الهاتف :"),
//                                     ),
//                                     //Text(snapshot.data['message'][index]['phone']),
//                                   ],
//                                 ),
//                                 // InkWell(
//                                 //   onTap: (){
//                                 //     showappointment==true;
//                                 //   },
//                                 //     child: Text("مواعيد الموظف")),
//                               ],
//                             )),
//                       ),
//                     );
//                     },
//                    )
//               );
//             }
//     ),
//           ),
//           // Container(
//           //   child: FutureBuilder(
//           //       builder: Controller.EmployeeApointement(context, employeeid :)),
//           // )
//         ],
//       );
//   }
// }

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/model/bussnise_employee.dart';
import 'package:toordor/model/employeeappointment.dart';
import 'package:toordor/view/screen/home_page.dart';

import '../../model/employee_services.dart';
import '../../model/services.dart';
import '../../model/services_bussnise.dart';

class ShowEmployee extends StatefulWidget {
  const ShowEmployee({Key? key}) : super(key: key);

  @override
  State<ShowEmployee> createState() => _ShowEmployeeState();
}

class _ShowEmployeeState extends State<ShowEmployee> {
  bool showAppointment = false;
  bool showEmployee = false;
  String service = "";
  String employee = "";
  int idServices = 0;
  int idemployee = -1;

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
      appBar: AppBar2(context: context),
      body: Column(
        children: [
          FutureBuilder<dynamic>(
              future: Controller.userData(context),
              builder: (context, userData) {
                if (userData.hasData) {
                  return FutureBuilder<List<ServicesBussnise>>(
                      future: Controller.ServicesBussnises(context,
                          bussniseid:
                              userData.data['message']['bussinees_id'] ?? -1),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.grey[300]),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        hint: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(service.isEmpty
                                              ? "اختر الخدمة".tr()
                                              : service),
                                        ),
                                        items: snapshot.data!.map((value) {
                                          return DropdownMenuItem(
                                            enabled: true,
                                            onTap: () =>
                                                idServices = value.id ?? 1,
                                            value: value.serviceName,
                                            child: Text(
                                              value.serviceName ?? '',
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                            service = val.toString();
                                            showEmployee = true;
                                          });
                                        }))),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Visibility(
            visible: showEmployee,
            child: FutureBuilder<List<ServicesEmployee>>(
                future:
                    Controller.servicesEmployee(context, idServices.toString()),
                builder: (context, snapshot) {
                  print("=============");
                  print(idServices.toString());

                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey[300]),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(employee.isEmpty
                                        ? "اختر موظف".tr()
                                        : employee),
                                  ),
                                  items: snapshot.data?.map((value) {
                                    return DropdownMenuItem(
                                      enabled: true,
                                      onTap: () {
                                        idemployee = value.id ?? 1;
                                        print('idServices == $idemployee');
                                      },
                                      value: value.name,
                                      child: Text(
                                        value.name ?? '',
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      employee = val.toString();
                                      showAppointment = true;
                                    });
                                  }))),
                    );
                  } else {
                    print(snapshot.error);
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Visibility(
              visible: true,
              child: FutureBuilder<dynamic>(
                  future: Controller.employeeApointement(context,
                      employeeid: idemployee),
                  builder: (BuildContext context, snapshot) {
                    print(idemployee);
                    print(snapshot.data);
                    if (snapshot.hasData &&
                        snapshot.data["message"] !=
                            "هذا المستخدم ليس لديه عمل ") {
                      return Expanded(
                        flex: 4,
                        child: ListView.builder(
                            itemCount: snapshot.data['data']?.length ?? -1,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 250,
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text("ملاحظات:".tr()),
                                            Text(snapshot.data?['data'][index]
                                                    ['comments'] ??
                                                ''),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("اسم المستخدم".tr()),
                                            Text(snapshot.data?['data'][index]
                                                    ['user']['name'] ??
                                                ''),
                                          ],
                                        ),
                                        snapshot.data['data'][index]['user'] !=
                                                null
                                            ? Row(
                                                children: [
                                                  Text("هاتف المستخدم:".tr()),
                                                  Text(snapshot.data?['data']
                                                              [index]['user']
                                                          ['phone'] ??
                                                      ''),
                                                ],
                                              )
                                            : Text(""),
                                        Row(
                                          children: [
                                            Text("اسم العمل:".tr()),
                                            Text(snapshot.data?['data'][index]
                                                    ['businees']['name'] ??
                                                ''),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("اسم الخدمة:".tr()),
                                            Text(snapshot.data?['data'][index]
                                                    ['service']['name'] ??
                                                ''),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("من".tr()),
                                            Text(snapshot.data?['data'][index]
                                                    ['from_date'] ??
                                                ''),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("الى".tr()),
                                            Text(snapshot.data?['data'][index]
                                                    ['to_date'] ??
                                                ""),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("التاريخ:".tr()),
                                            Text(snapshot.data?['data'][index]
                                                    ['date_day'] ??
                                                ""),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      // print("failed");
                      // Text("gggg");
                      return Center(
                        child: Container(
                            height: 100, child: Text("لايوجد اي مواعيد".tr())),
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
