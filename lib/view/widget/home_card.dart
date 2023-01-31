


import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {

   HomeCard({Key? key,required this.index}) : super(key: key);
int index ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width:30 ,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ) ,
      child: Image.asset("assets/instagram.png")

    );
  }
}
