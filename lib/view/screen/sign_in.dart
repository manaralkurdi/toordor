import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toordor/Controller/controller.dart';

import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/View/Widget/background.dart';

class SignIN extends StatefulWidget {
  SignIN({Key? key}) : super(key: key);

  @override
  State<SignIN> createState() => _SignINState();
}

class _SignINState extends State<SignIN> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  Controller controller = Controller();

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
      floatingActionButton: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: FutureBuilder<List>(
        //   future: controller.rssToJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasData == true) {
            return const Center(child: Text("لا توجد بيانات "));
          } else if (snapshot.hasData == false) {
            return Background(
              items: [
                // Expanded(
                //     child:
                //     ListView.builder(
                //      itemCount: snapshot.data?.length??0,
                //       itemBuilder: (context,i){
                //       if(snapshot.data!=null)  {
                //      return ListTile(
                //         title: Text(snapshot.data![i].fullName),
                //       );
                //     }else{
                //         return const Center(child: Text('k'),);
                //       }
                //   },
                // )),
                const SizedBox(height: 10),
                TextForm(
                    hint: 'رقم الهاتف',
                    controller: email,
                    keyBoardType: TextInputType.phone),
                TextForm(
                    hint: 'كلمه المرور',
                    controller: password,
                    visibility: true),
                const SizedBox(height: 15),
                ElevatedButton(
                    onPressed: () async {
                      //controller.fetchAllUsers(context, email.text),
                    },
                    // controller.login(context, user: email.text, password: password.text),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: Colors.white),
                    )),
                // ElevatedButton(child: Text('Send SMS'),onPressed: ()=>controller.sendSMS(),)
              ],
            );
          } else {
            return const Center(child: Text('شي ما غامض!'));
          }
        },
      ),
    );
  }
}
