import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/calender.dart';
import 'package:toordor/View/Widget/home_card.dart';
import 'package:http/http.dart' as http;
import '../../const/urlLinks.dart';
import 'business_details.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

extension NumExtensions on num {
  bool get isInt => (this % 1) == 0;
}

class _HomeBodyState extends State<HomeBody> {
  int perPageItem = 9;

  late int pageCount;
  int selectedIndex = 0;
  late int lastPageItemLength;
  late PageController pageController;
  List items=[];
  @override
  void initState() {

    Future fetchAllBusinesses(BuildContext context,
        {required String token}) async {
      http.Response response = await http.get(Uri.parse(getBusinesses), headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {

        Map<String, dynamic> data = json.decode(response.body);
        items = data['data']??[];

      } else {
        showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              content: Text('حدث خطا ما  ${response.statusCode}'),
            ));
      }
    }

    pageController = PageController(initialPage: 0);
    for (var i in items) {}
    var num = (items.length / perPageItem);
    pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

    var reminder = items.length.remainder(perPageItem);
    lastPageItemLength = reminder == 0 ? perPageItem : reminder;
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "مرحبا منار",
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () => Controller.navigatorGo(context, Calender()),
                child: Text(
                  "مواعيدي",
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),

            ],
          ),
        ),
        Flexible(
          flex: 16,
          child:items.isNotEmpty? PageView.builder(
              controller: pageController,
              itemCount: pageCount,
              onPageChanged: (index) => setState(() => selectedIndex = index),
              itemBuilder: (_, pageIndex) {
                return GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  primary: false,
                  childAspectRatio: 1.1,
                  shrinkWrap: true,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 3,
                  children: List.generate(
                      (pageCount - 1) != pageIndex
                          ? perPageItem
                          : lastPageItemLength, (index) {
                    return GestureDetector(
                      onTap: () =>Controller.navigatorGo(context, BusinessDetails()),
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.all(12),
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child:null
                        //Image.asset(
                          //Controller
                           //   .category[index + (pageIndex * perPageItem)],
                        //),
                      ),
                    );
                  }),
                );
              }):const Center(
            child: Text('لا توجد اي عناصر',style: TextStyle(
              fontSize: 18
            ),),
          )
          //   Column(
          //   children: [
          //     Row(
          //       children: [HomeCard()],
          //     ),
          //     Row(children: [],) ,
          //     Row(children: [],),
          //   ],
          // );
        ),
        Flexible(
            flex: 1,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: pageCount,
                itemBuilder: (_, index) {
                  return GestureDetector(
                      onTap: () {
                        pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            color: Colors.red
                                .withOpacity(selectedIndex == index ? 1 : 0.5)),
                        margin: const EdgeInsets.all(5),
                        width: 10,
                        height: 10,
                      ));
                })),
        Flexible(
          flex: 7,
          child: Container(
           child: Text('ads',style: TextStyle(fontSize: 90),),
          ),
        )
      ]),
    ));
  }
}
