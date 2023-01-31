import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'package:toordor/View/Screen/calender_event.dart';
import 'package:time_range/time_range.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/model/services_bussnise.dart';
//import 'package:toordor/view/screen/appointement.dart';
import 'package:toordor/view/screen/calender_event.dart';
import 'package:toordor/view/screen/home_page.dart';

class TimeWorkPlace extends StatefulWidget {


  const TimeWorkPlace({Key? key}) : super(key: key);
  State<TimeWorkPlace> createState() => _TimeWorkPlaceState();
}

class _TimeWorkPlaceState extends State<TimeWorkPlace> {
  final Connectivity _connectivity = Connectivity();
  bool isLoading = false;
  TextEditingController message = new TextEditingController();
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

  TimeOfDay selectedTime = TimeOfDay.now();
  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;
  String fromdate = "";
  String todate = "";
  String todatebreak = "";
  String fromdatebreak = "";
  List<String> weekdays = [
    "Friday".tr(),
    "Saturday".tr(),
    "Sunday".tr(),
    "Monday".tr(),
    "Thursday".tr(),
    "Wednesday".tr(),
    "Thuesday".tr()
  ];
  List<String> weekdays_selectuser = [];
  bool select = false;
  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 50),
    const TimeOfDay(hour: 15, minute: 20),
  );
  final _defaultTimeRangebreak = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 50),
    const TimeOfDay(hour: 15, minute: 20),
  );
  TimeRangeResult? _timeRangeday;
  TimeRangeResult? _timeRangebreak;
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
    print(str);
    return str;
  }

  String service = "";
  int idServices = 0;
  int idBussnise=0;
  late StateSetter _setState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar2(context: context),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<List<Message>>(
                future: Controller.getServiceEmployeeAccept(context),
                builder: (context, userData) {
                  if (userData.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey[300]),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  hint: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(service.isEmpty
                                        ? "اختر الخدمة".tr()
                                        : service),
                                  ),
                                  items: userData.data!.map((value) {
                                    return DropdownMenuItem(
                                      enabled: true,
                                      onTap: () {
                                  //      print(userData.data);
                                        idServices = value.serviceId ?? 0;
                                        idBussnise=value.busineesId??0;
                                        print(idServices);
                                        print(value.service!.serviceName);
                                      },
                                      value: value.service!.serviceName,
                                      child: Text(
                                        value.service?.serviceName ?? '',
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      service = val.toString();
                                      //  showEmployee = true;
                                    });
                                  }))),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: StatefulBuilder(
                            builder: (BuildContext context, setstate) {
                              return FutureBuilder<dynamic>(
                                  future: Controller.userData(context),
                                  builder: (context, snapshot) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 16,
                                              left: leftPadding,
                                              right: 10),
                                          child: Text(
                                            'اختر الوقت'.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: dark),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TimeRange(
                                          fromTitle: Column(
                                            children: [
                                              const Divider(
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
                                              const Divider(
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
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: dark,
                                          ),
                                          activeTextStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          borderColor: Colors.transparent,
                                          activeBorderColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          activeBackgroundColor: dark,
                                          firstTime:
                                          const TimeOfDay(hour: 8, minute: 00),
                                          lastTime:
                                          const TimeOfDay(hour: 20, minute: 00),
                                          initialRange: _timeRangeday,
                                          timeStep: 15,
                                          timeBlock: 15,
                                          onRangeCompleted: (range) =>
                                              setState(() {
                                                _timeRangeday = range;
                                                _textSelect(_timeRangeday?.start
                                                    .format(context) ??
                                                    "");
                                                _textSelect(_timeRangeday?.end
                                                    .format(context) ??
                                                    "");
                                              }),
                                        ),
                                        TimeRange(
                                            fromTitle: Column(
                                              children: [
                                                const Divider(
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  'الاستراحة من'.tr(),
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
                                                const Divider(
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  'الاستراحة الى'.tr(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: dark,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            titlePadding: leftPadding,
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: dark,
                                            ),
                                            activeTextStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                            borderColor: Colors.transparent,
                                            activeBorderColor: Colors
                                                .transparent,
                                            backgroundColor: Colors.transparent,
                                            activeBackgroundColor: dark,
                                            firstTime: const TimeOfDay(
                                                hour: 8, minute: 00),
                                            lastTime: const TimeOfDay(
                                                hour: 20, minute: 00),
                                            initialRange: _timeRangebreak,
                                            timeStep: 15,
                                            timeBlock: 15,
                                            onRangeCompleted: (range) =>
                                                setState(() {
                                                  _timeRangebreak = range;
                                                  _textSelect(
                                                      _timeRangebreak?.start
                                                          .format(context) ??
                                                          "");
                                                  _textSelect(
                                                      _timeRangebreak?.end
                                                          .format(context) ??
                                                          "");
                                                })),
                                        const Divider(),
                                        Center(
                                            child: Text("اوقات الاجازة".tr())),
                                        Container(
                                          height: 100,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: weekdays.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setstate(() {
                                                            weekdays_selectuser
                                                                .contains(
                                                                weekdays[index]) ==
                                                                true
                                                                ? weekdays_selectuser
                                                                .remove(
                                                                weekdays[index])
                                                                : weekdays_selectuser
                                                                .add(
                                                                weekdays[index]);
                                                            print(
                                                                weekdays_selectuser);
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 30,
                                                          width: 90,
                                                          decoration: BoxDecoration(
                                                            border: Border
                                                                .all(),
                                                            color: weekdays_selectuser
                                                                .contains(
                                                                weekdays[
                                                                index]) ==
                                                                true
                                                                ? Colors.blue
                                                                : Colors.white,
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                                  weekdays[index])),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              }),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: leftPadding),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // Text(
                                              //   'Selected Range: ${_timeRangeday!.start.format(context)} - ${_timeRangeday!.end.format(context)}',
                                              //   style: TextStyle(
                                              //       fontSize: 20, color: dark),
                                              // ),
                                              MaterialButton(
                                                child: Text('حفظ'.tr()),
                                                onPressed: () {
                                                  print(snapshot.data);
                                                  //
                                                  // String _textSelect(String str) {
                                                  //   str = str.replaceAll("ص", "");
                                                  //   str=str.replaceAll("م", "");
                                                  //   print(str);
                                                  //   return str;
                                                  // }
                                                  // _textSelect(_timeRangebreak?.start.format(context)??"");
                                                  // _textSelect(_timeRangebreak?.end.format(context)??"");
                                                  // _textSelect(_timeRangeday?.start.format(context)??"");
                                                  // _textSelect(_timeRangeday?.end.format(context)??"");

                                                  Controller.workHoursEmployee(
                                                    context,
                                                    bussniseid: idBussnise,
                                                    fromdate: _textSelect(
                                                        _timeRangeday?.start
                                                            .format(context) ??
                                                            ""),
                                                    service_id: idServices,
                                                    todate: _textSelect(
                                                        _timeRangeday?.end
                                                            .format(context) ??
                                                            ""),
                                                    fromdatebreak: _textSelect(
                                                        _timeRangebreak?.start
                                                            .format(context) ??
                                                            ""),
                                                    todatebreak: _textSelect(
                                                        _timeRangebreak?.end
                                                            .format(context) ??
                                                            ""),
                                                    weekend: weekdays_selectuser
                                                        .toString(),
                                                    employeeid: snapshot
                                                        .data['message']['employee_id'],
                                                  );


                                                  print(
                                                      'fromdate == ${_textSelect(
                                                          _timeRangeday?.start
                                                              .format(
                                                              context) ??
                                                              '')}');
                                                  print(idBussnise);
                                                  print(idServices);
                                                  print(
                                                      'todate == ${_textSelect(
                                                          _timeRangeday?.end
                                                              .format(
                                                              context) ??
                                                              '')}');
                                                  // EmployeeCubit.get(context)
                                                  //     .createEmployeeWorkhours(
                                                  //     busineesId: '1',
                                                  //     breakFrom: '12:00',
                                                  //     breakTo: '13:00',
                                                  //     fromDate: '10:00',
                                                  //     toDate: '15:00',
                                                  //     weekends: ['Friday']);

                                                  setState(() {
                                                    _timeRangeday =
                                                        _defaultTimeRange;
                                                    _timeRangebreak =
                                                        _defaultTimeRangebreak;
                                                  });
                                                  // print(_timeRange!.);
                                                },
                                                color: orange,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            }),
                        );
                      });
                });
                selectedDay = selectDay;
                focusedDay = focusDay;
            //    print(focusedDay);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              // eventLoader: _getEventsfromDay,

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
          ],
        ),
      ),
    );
  }
}
