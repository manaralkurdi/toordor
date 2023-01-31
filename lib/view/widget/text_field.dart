import 'package:flutter/material.dart';
import 'package:toordor/view/widget/constant.dart';

class TextFormCustome extends StatelessWidget {
  String ? hint;
  String ?labelText;
  Widget? widget;
  bool? visibility;
  TextEditingController? controller;
  TextInputType? keyBoardType;
  ValueChanged<String>? onchange;
  IconButton ? icon;
  TextFormCustome({
    Key? key,
    required this.hint,
    this.widget,
    this.visibility,
    this.keyBoardType,
    this.controller,
    this.onchange,
    this.icon,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.transparent),
          // margin: const EdgeInsets.symmetric(vertical:12,horizontal: 20),
          //  padding: const EdgeInsets.symmetric( vertical:3,),
          child: TextField (
              keyboardType:keyBoardType ,
              obscureText: visibility ?? false,
            controller: controller,
              decoration: InputDecoration(
                suffixIcon: widget,

                hintText:labelText ,
                labelText:hint ,
                errorStyle: TextStyle(
                  color: Colors.red,
                  wordSpacing: 5.0,
                ),
                labelStyle: TextStyle(
                    color: ColorCustome.coloryellow,
                    letterSpacing: 1.3,
                  fontSize: 10
                ),
                hintStyle: TextStyle(
                    letterSpacing: 1.3,
                    color: ColorCustome.colorgrey,
                    fontSize: 10
                ),

                contentPadding: EdgeInsets.all(20.0), // Inside box padding
                border: OutlineInputBorder(
                  gapPadding: 1.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorCustome.colorblue, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:ColorCustome.colorblue, width: 2.0),
                ),
              )
          )
      );}
