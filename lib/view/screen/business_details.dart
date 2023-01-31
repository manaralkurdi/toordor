// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class EmpleyDate {
//   EmpleyDate({required this.empley, required this.selectedDate});
//
//   String empley;
//   DateTime? selectedDate;
// }
//
// class BusinessDetails extends StatefulWidget {
//   BusinessDetails({Key? key}) : super(key: key);
//
//   @override
//   State<BusinessDetails> createState() => _BusinessDetailsState();
// }
//
// class _BusinessDetailsState extends State<BusinessDetails> {
//   DateTime toDay = DateTime.now();
//
//   DateTime? selectedDate;
//
//   String empley = '';
//
//   List<EmpleyDate> dates = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Image.asset(
//             'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
//         actions: [
//           IconButton(icon: const Icon(Icons.search), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.date_range), onPressed: () {}),
//         ],
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             child:  Text('اضف ميعاد'.tr()),
//             onPressed: () {},
//           ),
//           // Expanded(
//           //   child: TableCalendar(
//           //     currentDay: toDay,
//           //     firstDay: DateTime(toDay.year - 5, toDay.month, toDay.day),
//           //     lastDay: DateTime(toDay.year + 5),
//           //     focusedDay: DateTime(toDay.year, toDay.month, toDay.day ),
//           //     onDaySelected: (DateTime date, date2) {
//           //       setState(() => date=toDay);
//           //       // showDialog(
//           //       //     context: context,
//           //       //     builder: (context) => CupertinoAlertDialog(
//           //       //             content: SizedBox(
//           //       //           height: MediaQuery.of(context).size.height * 0.7,
//           //       //           // width: 100,
//           //       //           child: GridView.builder(
//           //       //             gridDelegate:
//           //       //                 const SliverGridDelegateWithFixedCrossAxisCount(
//           //       //                     crossAxisCount: 2),
//           //       //             itemBuilder: (context, index) {
//           //       //               return TextButton(
//           //       //                 onPressed: () {
//           //       //
//           //       //                   // selectedDate = date;
//           //       //                   // empley = 'empolyee $index';
//           //       //                   // print(selectedDate);
//           //       //                   // print(empley);
//           //       //                   // dates.add(EmpleyDate(
//           //       //                   //     empley: empley,
//           //       //                   //     selectedDate: selectedDate));
//           //       //                   // Navigator.pop(context);
//           //       //                 },
//           //       //                 child: Container(
//           //       //                   alignment: Alignment.center,
//           //       //                   margin: const EdgeInsets.symmetric(
//           //       //                       vertical: 5, horizontal: 3),
//           //       //                   decoration: BoxDecoration(
//           //       //                       border: Border.all(width: .6),
//           //       //                       borderRadius: BorderRadius.circular(12)),
//           //       //                   child: Text('empolyee $index'),
//           //       //                 ),
//           //       //               );
//           //       //             },
//           //       //             itemCount: 30,
//           //       //           ),
//           //       //         )));
//           //     },
//           //     onRangeSelected: (range1, range2, range3) {},
//           //   ),
//           // ),
//           // Expanded(child: ValueListenableBuilder<List<EmpleyDate>>(valueListenable: press(dates,index,context) , builder: (BuildContext context, value, Widget? child) {  },))
//         ],
//       ),
//     );
//   }
// }
