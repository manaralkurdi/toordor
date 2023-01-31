


import 'package:flutter/material.dart';
import 'package:toordor/view/widget/constant.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0,left: 15,right: 15),
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Text("مرحبا كيف يمكننا مساعدتك",style: TextStyle(fontSize: 20,color: ColorCustome.colorblue),)
            ],
          ),
        ),
      ),
    );
  }
}
