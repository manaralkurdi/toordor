// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:toordor/controller/controller.dart';
// import 'package:toordor/controller/size.dart';
// import 'package:toordor/view/widget/TextForm.dart';
//
// class ChangePassword extends StatefulWidget {
//   ChangePassword({Key? key}) : super(key: key);
//
//   @override
//   State<ChangePassword> createState() => _ChangePasswordState();
// }
//
// class _ChangePasswordState extends State<ChangePassword> {
//   final TextEditingController password = TextEditingController(),
//       rePassword = TextEditingController();
//
//   final Connectivity _connectivity = Connectivity();
//
//   bool isLoading = false;
//
//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       print("Error Occurred: ${e.toString()} ");
//       return;
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//     return _UpdateConnectionState(result);
//   }
//
//   void showStatus(ConnectivityResult result, bool status) {
//     final snackBar = SnackBar(
//         content:
//         Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
//         backgroundColor: status ? Colors.green : Colors.red);
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
//
//   Future<void> _UpdateConnectionState(ConnectivityResult result) async {
//     if (result == ConnectivityResult.mobile ||
//         result == ConnectivityResult.wifi) {
//       setState(() {
//         isLoading = false;
//         //     showStatus(result, true);
//       });
//     } else {
//       setState(() {
//         //  showStatus(result, false);
//         isLoading = true;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading ==false?
//     Scaffold(
//       body: SizedBox(
//         width: MySize.width(context),
//         height: MySize.height(context),
//         child: Column(
//           children: [
//             SizedBox(height: MySize.height(context)/3),
//             TextForm(hint: 'كلمه المرور',controller: password,),
//             TextForm(hint: "تاكيد كلمه المرور",controller: rePassword,),
//             SizedBox(height: MySize.height(context)/10),
//             ElevatedButton(onPressed: ()=>Controller.restPassword(context, confiremPassword: rePassword.text, password: password.text), child:const Text('تغيير كلمه المرور'))
//           ],
//         ),
//       ),
//     ): Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Text("please check internetconnection"),
//                   CircularProgressIndicator(),
//                 ],
//               ),
//             )
//           ],
//         ));
//   }
// }
