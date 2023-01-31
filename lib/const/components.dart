import 'package:flutter/material.dart';
import 'package:toordor/const/color.dart';
import 'package:toordor/view/widget/constant.dart';

Widget DefaultButton({
  double width = 280,
  Color color = ColorCustome.colorblue,
  Color text_color = Colors.white,
  FontWeight text_font_weight = FontWeight.bold,
  required VoidCallback controll,
  required String text,
  double radius = 7.5,
}) =>
    Column(
      children: [
        Container(
          width: width,
          height: 40,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(radius)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: MaterialButton(
              onPressed: controll,
              child: Text(
                text.toUpperCase(),
                style: TextStyle(color: text_color, fontWeight: text_font_weight),
              )),
        ),
      ],
    );
Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defualtTextFormField(
        {required TextEditingController controller,
        required TextInputType type,
        FormFieldValidator<String>? validator,
         IconData? prefix,
        IconData? suffix,
        double radius = 8.5,
        double width = 280,
        double height = 40,
        VoidCallback? suffix_hand,
        bool password = false,
        required String label,
        GestureTapCallback? ontap}) =>
    Container(
      width: 280,
      height: 40,
      child: TextFormField(
        controller: controller,
        validator: validator,
        onTap: ontap,
        obscureText: password,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
            onPressed: suffix_hand,
            icon: Icon(suffix),
          ),
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
