import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/Controller/controller.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/View/Screen/home.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/show_bussnise_appointment.dart';

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
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
  bool hasbussnise=false;
  fetch() async {
    prefs = await SharedPreferences.getInstance();
   // bussniseid = prefs.getString('StringTranslate') ?? bussniseid;
    hasbussnise = prefs.getBool("has_bussinees")??false;
    print(hasbussnise);
  }
  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
              height: MySize.height(context) / 4, width: MySize.width(context)),
           Text('هل انت متـأكد من تسجيل الخروج'.tr(),
              style: TextStyle(fontSize: 22)),
          SizedBox(height: MySize.height(context) / 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: MySize.width(context) / 9),
              ElevatedButton(
                  onPressed: () => Controller.logout(context),
                  child:  Text('نعم'.tr())),
              SizedBox(width: MySize.width(context) / 10),
              ElevatedButton(
                  onPressed: () {

                    Controller.navigatorOff(context,hasbussnise?ShowBussniseAppointment(): HomeBodyCategory());

                  },
                  child:  Text('لا'.tr())),
              SizedBox(width: MySize.width(context) / 10),
            ],
          )
        ],
      )),
    );
  }
  showAlertDialog(BuildContext context,) {

    // set up the buttons
    Widget remindButton = TextButton(
      child: Text("تاكيد".tr()),
      onPressed:  () {
        Controller.logout(context);

      },
    );
    Widget cancelButton = TextButton(
      child: Text("الغاء".tr()),
      onPressed:  () {
       // Controller.navigatorOff(context, HomeBodyCategory());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("هل انت متأكد من الغاء الطلب ".tr()),
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
