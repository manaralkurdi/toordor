
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/View/Screen/home.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/view/Widget/TextForm.dart';
import 'package:toordor/model/bussnise_profile.dart';
import 'package:toordor/view/block/cubit/home_cubit.dart';
import 'package:toordor/view/block/state/home_state.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/screen/show_bussnise_appointment.dart';
import '../../controller/controller.dart';

class BussniseProFile extends StatefulWidget {
  BussniseProFile({Key? key}) : super(key: key);

  @override
  State<BussniseProFile> createState() => _BussniseProFileState();
}

class _BussniseProFileState extends State<BussniseProFile> {
  late int bussinse;
 // late SharedPreferences preferences ;
  late SharedPreferences prefs;
  bool isLoading = false;
  final Connectivity _connectivity = Connectivity();
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
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
  TimeOfDay? _selectedTime;
  String formText ="";

  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt('integer', bussinse);
  }
    String utcTo12HourFormat(String bigTime) {
      var df =  DateFormat("h:mma");
      var dt = df.parse('6:45PM');
      print(DateFormat('HH:mm').format(dt));
      DateTime tempDate = DateFormat("HH:mm").parse(bigTime);
      //print(tempDate);
      var dateFormat = DateFormat("HH:mm"); // you can change the format here
      var utcDate = dateFormat.format(tempDate); // pass the UTC time here
      var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
      //String createdDate = DateFormat.Hm().format(tempDate);
     // print("------------$createdDate");
      return createdDate;
    }
  String time12to24Format(String time) {
// var time = "12:01 AM";
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String meridium = time.split(":").last.split(" ").last.toLowerCase();
    if (meridium == "pm") {
      if (h != 12) {
        h = h + 12;
      }
    }
    if (meridium == "am") {
      if (h == 12) {
        h = 00;
      }
    }
    String newTime = "${h == 0 ? "00" : h}:${m == 0 ? "00" : m}";
    print(newTime);
    return newTime;
  }
    //DateFormat.Hm().format(date);

String   fromtodate = "";
  String pm="";
  String concat = "";
  @override
  void initState() {
    utcTo12HourFormat("11:00");
   // time12to24Format("11:00");
   /// utcTo12HourFormat("12:00");
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

     return   Scaffold(
          appBar: AppBar2(context:context),
            body: FutureBuilder<dynamic>(
              future: Controller.userData(context),
              builder: (context,userData) {
                print(userData.data);
             if(userData.hasData)   {

               bussinse=userData.data['message']['bussinees_id']??0;
              // print(userData.data[]);
        return FutureBuilder<dynamic>(
            future: Controller.getBussnisebyid(context, businessId:bussinse),
            builder: (context, snapshot) {
              save();
              if (snapshot.hasData) {
                fromtodate= snapshot.data?['data'][0]['to_date']??"";
                print(fromtodate);
                pm="PM";
                concat=fromtodate+pm;
                print(concat);
                var df =  DateFormat("h:mm");
                var dt = df.parse(concat);
                concat = DateFormat('HH:mm').format(dt);
                print(DateFormat('HH:mm').format(dt));
                //utcTo12HourFormat("2.00");
           //     fromText =snapshot.data['data'][0]['to_date']
                //     ظظ parseTimeOfDay(snapshot.data['data'][0]['to_date']);
                print(snapshot.data?['data'][0]['business_name']??"");
                return SingleChildScrollView(
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
                                Text("معلومات العمل".tr(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                                // Padding(
                                //   padding: EdgeInsets.only(left: 13.0.sp),
                                //   child: CircleAvatar(
                                //     backgroundColor: Colors.grey,
                                //     child: const Text(""),
                                //     radius: 30.sp,
                                //   ),
                                // ),
                                // Text(
                                //   snapshot.data?.data?[0].businessName?? "",
                                //   style: const TextStyle(
                                //       fontSize: 15,
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.w700),
                                // )
                              ],
                            ),
                            SizedBox(height: MySize.height(context) / 20),
                            UserDataForm(
                              title: 'الاسم العمل'.tr(),
                              userData:  snapshot.data['data'][0]['business_name'],
                            ),
                            UserDataForm(
                              title: 'رقم الهاتف'.tr(),
                              userData: snapshot.data['data'][0]['phone'],
                            ),
                            UserDataForm(
                                title: 'البريد الالكتروني'.tr(),
                                userData: snapshot.data['data'][0]['email']),
                            UserDataForm(
                                title:translator.currentLanguage == 'ar'? 'اوقات الدوام من':"העסק פתוח מ",
                                userData: snapshot.data['data'][0]['from_date']),
                            UserDataForm(
                                title: 'اوقات الدوام الى'.tr(),
                                userData: concat),
                            UserDataForm(
                                title: "التخصصات".tr(),
                                userData: snapshot.data['data'][0]['specialization']),


                            // UserDataForm(
                            // title: 'المدينه',
                            // userData: cubit.address ?? "",
                            // ),
                            // UserDataForm(
                            // title: 'الدوله',
                            // userData: cubit.address ?? "",
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      onPressed: () => Controller.navigatorGo(
                                          context,
                                          EditUserData(
                                            fullName: snapshot
                                                .data?['data'][0]['business_name'].toString(),
                                            phone: snapshot.data?['data']
                                            [0] ['phone'],
                                            email: snapshot.data?['data']
                                            [0]['email'],
                                            from: snapshot.data?['data']
                                            [0] ['from_date'],
                                            to: snapshot.data?['data']
                                            [0] ['to_date'],
                                            specilize:snapshot.data?['data']
                                            [0] ['specialization'] ,
                                          )),
                                      child:  Text('تعديل'.tr())),

                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder:
                                          (context) => const ShowBussniseAppointment()
                                      ));
                                      },
                                    child:  Text('الغاء'.tr()),
                                  ),

                                ],
                              ),
                            ),
                            InkWell(
                                onTap: (){
                                  showAlertDialog(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                          decoration:BoxDecoration(
                                              border: Border.all(
                                              ),
                                              color: Colors.grey
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("حذف الحساب".tr()),
                                          )),
                                    ],
                                  ),
                                )),
                            SizedBox(height: MySize.height(context) / 20),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  // ElevatedButton(
                                  //     onPressed: () {}, child: const Text('حفظ')),
                                  // ElevatedButton(
                                  //     onPressed: () => Controller.navigatorGo(
                                  //         context,
                                  //         EditUserData(
                                  //           fullName: snapshot.data?['message']
                                  //               ['fullname'],
                                  //           phone: snapshot.data?['message']
                                  //               ['phone'],
                                  //           email: snapshot.data?['message']
                                  //               ['username'],
                                  //           country: snapshot.data?['message']
                                  //               ['country_id'],
                                  //           city: snapshot.data?['message']
                                  //               ['city_id'],
                                  //         )),
                                  //     child: const Text('تعديل')),
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     Navigator.pop(context);
                                  //   },
                                  //   child: const Text('الغاء'),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            });
      }
             else{
               return  Center(child:  CircularProgressIndicator());
             }
    }
            ));
  }
}

class UserDataForm extends StatelessWidget {
  UserDataForm({Key? key, this.title, this.userData}) : super(key: key);
  String? title;
  String? userData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title ?? '',
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            userData ?? '',
            style: TextStyle(fontSize: 13.sp),
            // textDirection: TextDirection.rtl,
            //textAlign: TextAlign.end,
          )
        ],
      ),
    );
  }
}

class EditUserData extends StatefulWidget {
  EditUserData(
      {Key? key,
        this.fullName,
        this.phone,
        this.email,
        this.from,
        this.to,
        this.specilize,

      })
      : super(key: key);
  final String? fullName, phone, email, from, to,specilize;

  @override
  State<EditUserData> createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {
  TimeOfDay? form;
  String  fromText="";
  TimeOfDay? to;
  String toText="";
  TextEditingController controller1 = TextEditingController();

  TextEditingController controller2 = TextEditingController();

  TextEditingController controller3 = TextEditingController();

  TextEditingController controller4 = TextEditingController();

  TextEditingController controller5 = TextEditingController();

  TextEditingController controller6 = TextEditingController();

  late SharedPreferences prefs;
  late BuildContext context;
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    int bussniseShared = prefs.getInt('integer') ?? 0;
    print(bussniseShared);
  }
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
  void addData() {
    controller1.text = widget.fullName ?? '';
    controller2.text = widget.phone ?? '';
    controller3.text = widget.email ?? '';
    controller4.text = widget.to ?? '';
    controller5.text = widget.from ?? '';
    controller6.text = widget.specilize ?? '';
  }
  TimeOfDay? _selectedTime;
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null)
      setState(() {
        _selectedTime = timePicked;
      });

    // Conversion logic starts here
    DateTime tempDate = DateFormat("h:m").parse(
        _selectedTime!.hour.toString() +
            ":" + _selectedTime!.minute.toString());
    var dateFormat = DateFormat("hh:mm"); // you can change the format here
    //print(dateFormat.format(tempDate));
    toText= _selectedTime!.hour.toString() +
        ":" + _selectedTime!.minute.toString();
    print(toText);
    //print(_selectedTime);
 //   print(tempDate);

  }

  @override
  Widget build(BuildContext context) {
    addData();
    return Scaffold(
        appBar: AppBar2(context:context),
        body: SingleChildScrollView(
          child: Column(children: [
            TextForm(hint: 'الاسم العمل'.tr(), controller: controller1),
            TextForm(hint: 'رقم الهاتف'.tr(), controller: controller2),
            TextForm(hint: 'البريد الالكتروني'.tr(), controller: controller3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:19.0),
                  child: Container(
                    width: 80,
                    child: FloatingActionButton(
                        heroTag: "hero1",
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(fromText.isEmpty ? 'من'.tr() : fromText),
                        )),
                        onPressed: () async => await showTimePicker(
                            context: context,
                            initialTime:form ?? TimeOfDay.now())
                            .then((value) => setState(() =>
                        fromText =
                        '${value?.hour ?? 0}:${value?.minute??0} '))
                    ),
                  ),
                ),
                Container(
                  width: 80,
                  child: FloatingActionButton(
                      heroTag: "hero2",
                      child: Text(toText.isEmpty ? 'الى'.tr() : toText),
                      onPressed: () async {
                        _selectTime(context);
                      }),
                ),
              ],
            ),

            // TextForm(hint: 'اوقات الدوام من'.tr(), controller: controller5),
            // TextForm(hint: 'اوقات الدوام الى'.tr(), controller: controller4),
            TextForm(hint: 'التخصصات'.tr(), controller: controller6),
            ElevatedButton(
              child: Text("حفظ التعديلات ".tr()),
              onPressed: () {
                setState((){
                Controller.DataEditBussnise(
                context,
                phone: controller2,
                name: controller1,
                email: controller3,
                to:toText,
                from: fromText,
                specilize: controller6
                );
                Controller.navigatorOff(context, ShowBussniseAppointment());
                fetch();
                });
              }

            ),

        ])));
  }
}

