import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../controller/controller.dart';
import '../widget/TextForm.dart';
import '../widget/background.dart';

class OTPScreenn extends StatefulWidget {
  const OTPScreenn(
      {Key? key})
      : super(key: key);


  @override
  State<OTPScreenn> createState() => _OTPScreennState();
}

class _OTPScreennState extends State<OTPScreenn> {
  TextEditingController otp = TextEditingController();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    //Random random =Random();
    // code=random.nextInt(100000).toString();
    //controller.sendSMS(code: code,phoneNumber: number);
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Background(
        items: [
          const SizedBox(height: 60),
          TextForm(
              hint: 'كود التاكيد'.tr(),
              controller: otp,
           //   icon: Container(),
              keyBoardType: TextInputType.phone),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {},
              child:  Text(
                'تأكيد'.tr(),
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}