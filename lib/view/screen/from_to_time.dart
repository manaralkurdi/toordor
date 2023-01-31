import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/view/screen/calender_event.dart';
import 'package:toordor/view/widget/utilites.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);
  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;
  final titleController = TextEditingController();

  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Controller controller = Controller();

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(
        Duration(hours: 2),
      );
    }
  }

  // final List<Event> _events = [];
  // List<Event> get events => _events;
  // void addEvent(Event event) {
  //   _events.add(event);
  // }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: CloseButton(),
      //   actions: buildEditingActions(),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // buildServiceName(),
            SizedBox(
              height: 12,
            ),
            buildDateTimePickers(),
          ],
        ),
      ),
    );
  }

  // List<Widget> buildEditingActions() => [
  //       ElevatedButton.icon(
  //         style: ElevatedButton.styleFrom(
  //           primary: Colors.transparent,
  //           shadowColor: Colors.transparent,
  //         ),
  //         onPressed: () {},
  //         icon: Icon(Icons.done),
  //         label: Text(
  //           'Save',
  //         ),
  //       ),
  //     ];

  Widget buildServiceName() => TextFormField(
        style: TextStyle(
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'title',
        ),
        onFieldSubmitted: (_) {},
        controller: titleController,
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );
  Widget buildFrom() => buildHeader(
        header: 'From',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(fromDate),
                onClicked: () => pickFromDateTime(
                  pickDate: false,
                ),
              ),
            ),
          ],
        ),
      );
  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        minLeadingWidth: 20,
        title: Text(
          text,
        ),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child,
        ],
      );
  Widget buildTo() => buildHeader(
        header: 'To',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2010, 8),
        lastDate: DateTime(2100),
      );
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (TimeOfDay == null) return null;
      final date = DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
      );
      final time = Duration(hours: timeOfDay!.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future saveForm() async {
    final event = Event(
      // from: fromDate,
      title: titleController.text,
      //  to: toDate,
    );
  }
}
