import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTimerPicker extends StatefulWidget {
  late final TimeOfDay intiTime;

  final Function(int selectedHour, int selectedMinute) onChanged;

  CustomTimerPicker({
    Key? key,
    required this.onChanged,
    TimeOfDay? intiTimeOfDay,
  }) : super(key: key) {
    intiTime = intiTimeOfDay ?? TimeOfDay.now();
  }

  @override
  State<CustomTimerPicker> createState() => _CustomTimerPickerState();
}

class _CustomTimerPickerState extends State<CustomTimerPicker> {
  late int selectedHour;
  late int selectedMinutes;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.intiTime.hour;
    selectedMinutes = widget.intiTime.minute;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // hour picker
        SizedBox(
          width: kToolbarHeight,
          child: CupertinoPicker(
            // backgroundColor: Colors.cyanAccent, //bg Color
            itemExtent: 50,
            onSelectedItemChanged: (v) {
              setState(() {
                selectedHour = v + widget.intiTime.hour;
              });
              widget.onChanged(
                selectedHour,
                selectedMinutes,
              );
            },
            children: List.generate(
              24 - widget.intiTime.hour,
                  (index) => Center(
                child: Text(
                  "${index + widget.intiTime.hour}",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),

        //minute Picker
        SizedBox(
          width: kToolbarHeight,
          child: CupertinoPicker(
            itemExtent: 50,
            onSelectedItemChanged: (v) {
              setState(() {
                selectedMinutes = v + widget.intiTime.minute;
              });
              widget.onChanged(
                selectedHour,
                selectedMinutes,
              );
            },
            children: List.generate(
              60 - widget.intiTime.minute,
                  (index) => Center(
                child: Text(
                  "${index + widget.intiTime.minute}",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}