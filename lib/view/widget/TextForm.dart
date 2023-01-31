import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  String hint;
  Widget? widget;
  bool? visibility;
  TextEditingController? controller;
  TextInputType? keyBoardType;
  ValueChanged<String>? onchange;
  IconButton ? icon;
  TextForm({
    Key? key,
    required this.hint,
    this.widget,
    this.visibility,
    this.keyBoardType,
    this.controller,
    this.onchange,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(width: 0),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100),
        margin: const EdgeInsets.symmetric(vertical:12,horizontal: 20),
        padding: const EdgeInsets.symmetric( vertical:3,),
        child: TextFormField(
          keyboardType:keyBoardType ,
          obscureText: visibility ?? false,

          controller: controller??TextEditingController(),
          decoration: InputDecoration(
            suffixIcon: widget,
            contentPadding: EdgeInsets.only(right: 8,bottom: 10),
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 12),
            border: InputBorder.none,
          ),

        ),
      );
}
