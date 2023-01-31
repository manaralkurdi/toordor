import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  VoidCallback? press;
  String? image;
  Color? color;

  HomeButton({Key? key,required this.image, this.press,this.color}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextButton(
    //  backgroundColor: Colors.white,
      child: Card(
          child: Image.asset(image??'',
          fit: BoxFit.fill,
          height: 40,
            width: 40,
          )),
      onPressed: press??(){},
    );
  }
}
