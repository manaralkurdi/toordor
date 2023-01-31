import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toordor/Controller/controller.dart';
import 'package:toordor/View/Screen/create_account.dart';
import 'package:toordor/View/Screen/home.dart';
import 'package:toordor/View/Widget/ImageButton.dart';
import 'package:toordor/View/Widget/TextForm.dart';
import 'package:toordor/View/Widget/socialmedia.dart';
import 'package:toordor/const/color.dart';

class Background extends StatelessWidget {
  Background({Key? key, required this.items, this.center = false})
      : super(key: key);
  List<Widget> items = [];
  bool center;
  int? height;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Controller c = Controller();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Wrap(
        children: [
          Stack(
            alignment: const Alignment(0, .5),
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Container(
                          child: Image.asset(
                            'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png',
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    height: h / 2,
                  )
                ],
              ),
              Card(
                elevation: 22,
                color: Colors.pink.withOpacity(0),
                child: Container(
                  width: w / 1.1,
                  height: h / 2.8,
                  child: Column(children: items),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: h / 1.6),
                  //SocialMedia(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
