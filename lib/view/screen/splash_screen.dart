import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/const/color.dart';

import '../../Controller/controller.dart';

class SplashScreen extends StatefulWidget {
 const SplashScreen({Key? key, required this.route}) : super(key: key);
 final Widget route;


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  getData() async => await Future.delayed(const Duration(seconds: 2))
      .whenComplete(() => Controller.navigatorOff(context, widget.route));

  @override
  void initState() {
    Controller.userData(context);
    super.initState();
    Future.delayed(const Duration(seconds: 3)).whenComplete(() => getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Image.asset(
            'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
            height: 70,
            width: 70,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
