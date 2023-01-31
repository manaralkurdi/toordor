import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';import 'dart:ui' as UI;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_range/time_range.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/model/appointment.dart';
import 'package:toordor/model/services_bussnise.dart';
import 'package:toordor/view/screen/calender.dart';
//import 'package:toordor/view/screen/appointement.dart';
import 'package:toordor/view/screen/from_to_time.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/screen/meeeting.dart';

import '../../model/employee_services.dart';
import '../../model/services.dart';

class CalendarEvent extends StatefulWidget {
  int bussniseId;
  CalendarEvent(this.bussniseId);

  @override
  _CalendarEventState createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  late Map<DateTime, List<Event>> selectedEvents;
  late Map<DateTime, List<Appointment>> _dataCollection;
TextEditingController userInput=  TextEditingController();
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final Connectivity _connectivity = Connectivity();
  bool isLoading = false;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
        Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        isLoading = false;
        //     showStatus(result, true);
      });
    } else {
      setState(() {
        //  showStatus(result, false);
        isLoading = true;
      });
    }
  }
  final TextEditingController _eventController = TextEditingController();
  bool bool1 = false;
  bool bool2 = false;
  bool bool3 = false;
  String serviceName = "";
  String services = "";
  String servicesEmployee = "";
  String idServices = "";
  TimeRangeResult? _timeRangeday;

  int idServicesemployee = 0;
  bool showServiceEmployee = false;
  Controller controller = Controller();
  late DateTime fromDate;
  late DateTime toDate;
  TimeOfDay? timePicked;
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;
  late var _calenderDataSource;
  final _defaultTimeRangebreak = TimeRangeResult(
    TimeOfDay(hour: 14, minute: 50,),
    TimeOfDay(hour: 15, minute: 20),
  );
  String _textSelect(String str) {
    str = str.replaceAll("ص", "");
    str = str.replaceAll("م", "");
    str = str.replaceAll("\u0660", "0");
    str = str.replaceAll("\u0668", "8");
    str = str.replaceAll("\u0661", "1");
    str = str.replaceAll("\u0662", "2");
    str = str.replaceAll("\u0663", "3");
    str = str.replaceAll("\u0664", "4");
    str = str.replaceAll("\u0665", "5");
    str = str.replaceAll("\u0666", "6");
    str = str.replaceAll("\u0667", "7");
    str = str.replaceAll("\u0669", "9");
   // print(str);
    return str;
  }

  @override
  void initState() {
    selectedEvents = {};
    //  _dataCollection = getAppointments();
    // _calenderDataSource = MeetingDataSource(<Meeting>[]);
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


  //  print(widget.bussniseId);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar2(context:context),
      body: Column(
        children: [
          FutureBuilder<List<ServicesBussnise>>(
              future: Controller.ServicesBussnises(
                  context, bussniseid:widget.bussniseId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey[300]),
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                hint: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      services.isEmpty ? "اختر الخدمة".tr() : services),
                                ),
                                items: snapshot.data!.map((value) {
                                  return DropdownMenuItem(
                                    enabled: true,
                                    onTap: () => idServices = value.id.toString() ?? "",
                                    value: value.serviceName,
                                    child: Text(
                                      value.serviceName ?? '',
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    services = val.toString();
                                    showServiceEmployee = true;
                                    print(idServices);
                                    print("____________________");
                                    print(widget.bussniseId);
                                  });
                                }))),
                  );
                } else {
                 // print(snapshot.error);
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          Visibility(
            visible: showServiceEmployee,
            child: FutureBuilder<List<ServicesEmployee>>(
                future:
                    Controller.servicesEmployee(context, idServices.toString()),
                builder: (context, snapshot) {
               //   print(idServices.toString());
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            width:250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey[300]),
                            child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    hint: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child:
                                      Text(
                                                      servicesEmployee.isEmpty
                                                          ? "اختر الموظف".tr()
                                                          : servicesEmployee,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                    ),
                                    items: snapshot.data!.map((value) {
                                      return DropdownMenuItem(
                                        enabled: true,
                                        onTap: () {
                                          idServicesemployee = value.id ?? 1;

                                          },
                                        value: value.name ?? "",
                                        child: Text(
                                          value.name ?? '',
                                        ),
                                      );
                                    }).toList(),
    onChanged: (val) {
            setState(() {
              servicesEmployee = val.toString();
              print("ppppppppppppppppp");
             print(idServicesemployee);
            });
            },

                                    ))),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(3),
                        //       color: Colors.grey[300]),
                        //   child: DropdownButtonHideUnderline(
                        //     child: DropdownButton(
                        //       isExpanded: true,
                        //       hint: Row(
                        //         children: [
                        //           const Icon(
                        //             Icons.list,
                        //             size: 16,
                        //             color: Colors.white,
                        //           ),
                        //           const SizedBox(
                        //             width: 4,
                        //           ),
                        //           Expanded(
                        //             child: Text(
                        //               servicesEmployee.isEmpty
                        //                   ? "اختر الموظف "
                        //                   : servicesEmployee,
                        //               style: const TextStyle(
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.white,
                        //               ),
                        //               overflow: TextOverflow.ellipsis,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       items: snapshot.data!.map((value) {
                        //         return DropdownMenuItem(
                        //           value: value.name ?? "",
                        //           child: Text(
                        //             value.name ?? '',
                        //             style: const TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.white,
                        //             ),
                        //             overflow: TextOverflow.ellipsis,
                        //           ),
                        //         );
                        //       }).toList(),
                        //       onChanged: (val) {
                        //         setState(() {
                        //           servicesEmployee = val.toString();
                        //           print(val);
                        //         });
                        //       },
                        //       icon: const Icon(
                        //         Icons.arrow_forward_ios_outlined,
                        //       ),
                        //       iconSize: 14,
                        //       iconEnabledColor: Colors.white,
                        //       iconDisabledColor: Colors.grey,
                        //       buttonHeight: 50,
                        //       buttonWidth: 160,
                        //       buttonPadding:
                        //           const EdgeInsets.only(left: 14, right: 14),
                        //       buttonDecoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(14),
                        //         border: Border.all(
                        //           color: Colors.black26,
                        //         ),
                        //         color: Colors.blue,
                        //       ),
                        //       buttonElevation: 2,
                        //       itemHeight: 40,
                        //       itemPadding:
                        //           const EdgeInsets.only(left: 14, right: 14),
                        //       dropdownMaxHeight: 200,
                        //       dropdownWidth: 200,
                        //       dropdownPadding: null,
                        //       dropdownDecoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(14),
                        //         color: Colors.blue,
                        //       ),
                        //       dropdownElevation: 8,
                        //       scrollbarRadius: const Radius.circular(40),
                        //       scrollbarThickness: 6,
                        //       scrollbarAlwaysShow: true,
                        //       offset: const Offset(-20, 0),
                        //     ),
                        //   ),
                        // ),
                      ],
                    );
                  } else {
                  //  print(snapshot.data);
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
          Expanded(
            child: TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  // print("===");
                  // print(selectedDay);
                  // print(selectedDay.month);
                  // print(widget.bussniseId);
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) async {
                // if (kDebugMode) {
                //   print('/////// timepick: $timePicked');
                // }
                setState(() {
                  print(selectedDay);
                  String date = DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(selectedDay.toString()));
                  var dateTime = DateTime.parse(selectedDay.toString());
                  var formate2 = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                  print(formate2);
                  print(date);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: FutureBuilder<dynamic>(
                              future: Controller.userData(context),
                              builder: (context,snapshot) {
                                return SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: leftPadding, right: 10),
                                        child: Text(
                                          'اختيارالوقت'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: dark),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      TimeRange(
                                        fromTitle: Column(
                                          children: [
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'من'.tr(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: dark,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        toTitle: Column(
                                          children: [
                                            Divider(
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'الى'.tr(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: dark,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        titlePadding: leftPadding,
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: dark,
                                        ),
                                        activeTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        borderColor: Colors.transparent,
                                        activeBorderColor: Colors.transparent,
                                        backgroundColor: Colors.transparent,
                                        activeBackgroundColor: dark,
                                        firstTime: TimeOfDay(hour: 5, minute: 00),
                                        lastTime: TimeOfDay(hour: 24, minute: 00),
                                        initialRange: _timeRangeday,
                                        timeStep: 15,
                                        timeBlock: 15,
                        onRangeCompleted: (range) =>
                                            setState(() {
                                              _timeRangeday = range;
                                            } ),
                                      ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height:40,
                                     // decoration:Box()
                                      child: TextFormField(
                                        textAlign: TextAlign.start,
                                      //  textDirection: TextDirection.RTL,
                                      controller: userInput,

                                      style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      ),
                                      decoration: InputDecoration(

                                      hintText: "اكتب الخدمة".tr()
                                      ),

                                      onChanged: (value) {
                                      }),
                                    ),
                                  ),
                                     InkWell(
                                       onTap:(){
                                         String date = DateFormat("yyyy-MM-dd ")
                                             .format(DateTime.parse(selectedDay.toString()));
                                  //       print(date);
                                         Controller.getAppointments(context,
                                             businessId:widget.bussniseId,
                                             serviceid: idServices,
                                             employeeId:idServicesemployee,
                                             date: date,
                                             fromDate : _textSelect(_timeRangeday?.start.format(context)??""),
                                             toDate:    _textSelect(_timeRangeday?.end.format(context)??""),
                                             comment: userInput);
                                         print( _textSelect(_timeRangeday?.start.format(context)??""),);
                                         print( _textSelect(_timeRangeday?.end.format(context)??""),);

                                       },
                                       child: Padding(
                                         padding: const EdgeInsets.all(20.0),
                                         child: Container(
                                           decoration: BoxDecoration(
                                             border: Border.all()
                                           ),
                                           height: 40,
                                           width:79,
                                           child: Center(child: Text("حفظ".tr())),

                                         ),
                                       ),
                                     )

                                    ],
                                  ),
                                );
                              }
                          ),
                        );
                      });
                });
               // log('////// selectedday: $focusDay');
               // print(widget.bussniseId);
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                // timePicked = await showTimePicker(
                //   context: context,
                //   initialTime: TimeOfDay.now(),
                // );
                //log('/////fomat date only: $focusedDay');
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              eventLoader: _getEventsfromDay,

              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text("Add Appointment"),
      //       content: TextFormField(
      //         controller: _eventController,
      //       ),
      //       actions: [
      //         TextButton(
      //           child: Text("Cancel"),
      //           onPressed: () => Navigator.pop(context),
      //         ),
      //         TextButton(
      //           child: Text("Ok"),
      //           onPressed: () {
      //             if (_eventController.text.isEmpty) {
      //             } else {
      //               if (selectedEvents[selectedDay] != null) {
      //                 selectedEvents[selectedDay]!.add(
      //                   Event(
      //                     title: _eventController.text,

      //                     // from: fromDate,
      //                     // to: toDate,
      //                   ),
      //                 );
      //               } else {
      //                 selectedEvents[selectedDay] = [
      //                   Event(
      //                     title: _eventController.text,
      //                     // from: fromDate,
      //                     // to: toDate,
      //                   ),
      //                 ];
      //               }
      //             }
      //             Navigator.pop(context);
      //             // _eventController.clear();
      //             setState(() {});
      //             return;
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      //   label: Text("Add Appointement"),
      //   icon: Icon(Icons.add),
      // ),
    );
  }
}

Future<TimeOfDay?> timePicker(BuildContext context) {
  return showTimePicker(
    initialTime: TimeOfDay.now(),
    context: context,
  );
}

class Event {
  final String title;

  Event({required this.title});

  String toString() => this.title;
}

class AppointmentDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
