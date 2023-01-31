


import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/model/category_model.dart';
import 'package:toordor/view/screen/add_project.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/setting_new.dart';
import 'package:toordor/view/widget/constant.dart';

import '../../controller/controller.dart';

class Mainpage extends StatelessWidget {
  Widget child;
  Widget childfloat;
   Mainpage({Key? key,required this.child,required this.childfloat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: childfloat,
        body: SingleChildScrollView(
          child: Container(
              height: 700,
              padding: const EdgeInsets.only(top: 20, right: 10,left:12),
              child: FutureBuilder<List<CategoryModel>>(
                  future: Controller.categoryy(context),
                  builder: (context, snapshot) {
                    return FutureBuilder<SharedPreferences>(
                        future: SharedPreferences.getInstance(),
                        builder: (context, snapshot) {
                          return child;
                        });
                  })),
        ),
        bottomNavigationBar:
        Container(
          height: 40,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorCustome.coloryellow,
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              color: ColorCustome.colorblue,
              borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingNew()));
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeBodyCategory()));
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProject()));
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      // Scaffold(
      //   appBar:AppBar2(context:context),
      //   body:FutureBuilder<List<CategoryModel>>(
      //     future: Controller.categoryy(context),
      //     builder: (context,snapshot) {
      //       return Padding(
      //         padding: const EdgeInsets.only(top: 20.0),
      //         child: Column(
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     FutureBuilder<SharedPreferences>(
      //                       future: SharedPreferences.getInstance(),
      //                       builder: (context, snapshot) {
      //                         if (snapshot.hasData) {
      //                           return Container(
      //                             padding: const EdgeInsets.only(top: 20, right: 10),
      //                             child: Row(
      //                               children: [
      //                                 Padding(
      //                                   padding: const EdgeInsets.only(left: 8.0),
      //                                   child: Text(
      //                                     "مرحبا".tr(),style: TextStyle(fontSize: 15),),
      //                                 ),
      //                                 Text( "${snapshot.data!.getString('fullname')}",
      //                                   style: TextStyle(
      //                                     fontSize: 15.sp,
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                           );
      //                         } else {
      //                           return const CupertinoActivityIndicator();
      //                         }
      //                       },
      //                     )
      //                   ],
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(bottom: 8.0, right: 8),
      //                   child: Row(
      //                     children: [
      //                       ElevatedButton(
      //                         style: ElevatedButton.styleFrom(primary: Colors.blue),
      //                         onPressed: () =>
      //                             Controller.navigatorGo(context, Calender()),
      //                         child: Text(
      //                           "مواعيدي".tr(),
      //                           style: TextStyle(
      //                             fontSize: 12.sp,
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding:  EdgeInsets.only(right: 8, top: 12),
      //                   child: Text(
      //                     'اختيار الخدمة'.tr(),
      //                     style: TextStyle(
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Expanded(
      //               flex: 2,
      //               child: Column(
      //                 children: [
      //                   Expanded(
      //                     child:
      //
      //                     FutureBuilder<List<CategoryModel>>(
      //                         future: Controller.categoryy(context),
      //                         builder: (context, snapshot) {
      //                           print(snapshot.data?.length);
      //                           var num = (snapshot.data?.length??0 / perPageItem);
      //                           pageCount = num.isInt ? num.toInt() : num.toInt() + 1;
      //
      //                           late int? reminder = snapshot.data?.length.remainder(perPageItem)??0;
      //                           lastPageItemLength = reminder == 0 ? perPageItem : reminder;
      //
      //                           if (snapshot.connectionState == ConnectionState.none) {
      //                             return  Center(
      //                                 child: Text('لا يتوافر اتصال بالانترنت'.tr()));
      //                           } else if (snapshot.hasData) {
      //                             return SizedBox(
      //                               height: 400,
      //                               child:
      //                               GridView.builder(
      //                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //                                     crossAxisCount: 3,
      //                                     crossAxisSpacing: 5,
      //                                     mainAxisSpacing: 3,
      //
      //                                   ),
      //                                   scrollDirection: Axis.horizontal,
      //                                   itemCount:snapshot.data?.length??0,
      //                                   shrinkWrap: false,
      //                                   itemBuilder: (context,index) {
      //                                     return Column(
      //                                         children: [
      //                                           GestureDetector(
      //                                               onTap: ()
      //                                               {
      //                                                 print(snapshot.data?[index].id??0);
      //                                                 Navigator.push(
      //                                                     context,
      //                                                     MaterialPageRoute(
      //                                                         builder: (context) =>
      //                                                             HomeBody1(
      //                                                                 snapshot.data?[index].id ?? 0
      //                                                             )));
      //                                               },
      //                                               child:
      //                                               Column(
      //                                                 children: [
      //                                                   Container(
      //                                                     width: 50,
      //                                                     height: 50,
      //                                                     decoration:  BoxDecoration(
      //                                                       borderRadius: BorderRadius.circular(10),
      //                                                       // color: Colors.blueAccent,
      //                                                     ),
      //                                                     child:CachedNetworkImage(
      //                                                       imageUrl:
      //                                                       snapshot.data?[index].image ?? "",
      //                                                       maxHeightDiskCache: 200,
      //                                                       //  maxWidthDiskCache: 100,
      //                                                       // images[index].toString()
      //                                                     ),
      //                                                   ),
      //                                                   // //          Container(
      //                                                   // //            height: 40,width: 60,
      //                                                   // //            decoration:BoxDecoration(
      //                                                   // //              borderRadius: BorderRadius.circular(20),
      //                                                   // //              color: Colors.blue
      //                                                   // // ),
      //                                                   // //            child: Image(
      //                                                   // // image:AssetImage(images?[index]??""),
      //                                                   // //              fit: BoxFit.cover,height:40,width: 60,),
      //                                                   // //          ),
      //                                                   //       ),
      //
      //
      //                                                   // Container(
      //                                                   //   width: 50,
      //                                                   //   height: 60,
      //                                                   //   decoration:  BoxDecoration(
      //                                                   //     borderRadius: BorderRadius.circular(10),
      //                                                   //
      //                                                   //   ),
      //                                                   //
      //                                                   //   child: Padding(
      //                                                   //     padding: const EdgeInsets.only(top: 8.0,bottom: 10),
      //                                                   //     child:
      //                                                   //     Image.network(
      //                                                   //       snapshot.data?[index].image.toString()??"",
      //                                                   //       height: 30,
      //                                                   //       width: 30,
      //                                                   //     ),
      //                                                   //   ),
      //                                                   // ),
      //                                                   //   margin: const EdgeInsets.all(5),
      //                                                   //   padding: const EdgeInsets.all(9),
      //                                                   //   alignment: Alignment.topCenter,
      //                                                   //   child: null,
      //                                                   // ),
      //
      //
      //                                                   Container(
      //                                                     child: Text(
      //                                                       '${category_?[index].toString()}',
      //                                                       // snapshot.data['data'][index]['name']!
      //                                                       //     .toString(),
      //                                                       style: const TextStyle(
      //                                                           color: Colors.black,
      //                                                           fontSize: 11),
      //                                                       overflow: TextOverflow.visible,
      //                                                       textAlign: TextAlign.center,
      //
      //                                                     ),
      //                                                   ),
      //                                                 ],
      //                                               ))]);
      //                                   }),
      //
      //
      //                             );
      //                           } else {
      //                             return const Center(child: CircularProgressIndicator());
      //                           }
      //                         }),
      //                   ),
      //                   // SizedBox(
      //                   //   height: 15.sp,
      //                   //   child: ListView.builder(
      //                   //     shrinkWrap: true,
      //                   //     scrollDirection: Axis.horizontal,
      //                   //     itemCount: 4,
      //                   //     itemBuilder: (_, index) {
      //                   //       return GestureDetector(
      //                   //         onTap: () => pageController.animateToPage(index,
      //                   //             duration: const Duration(milliseconds: 500),
      //                   //             curve: Curves.easeInOut),
      //                   //         child: AnimatedContainer(
      //                   //           duration: const Duration(milliseconds: 100),
      //                   //           decoration: BoxDecoration(
      //                   //               borderRadius:
      //                   //               const BorderRadius.all(Radius.circular(10)),
      //                   //               color: Colors.red
      //                   //                   .withOpacity(selectedIndex == index ? 1 : 0.5)),
      //                   //           margin: const EdgeInsets.all(5),
      //                   //           width: 10,
      //                   //           height: 10,
      //                   //         ),
      //                   //       );
      //                   //     },
      //                   //   ),
      //                   // )
      //                 ],
      //               ),
      //             ),
      //             Expanded(
      //                 child: Padding(
      //                   padding: EdgeInsets.all(8.0),
      //                   child: SizedBox(
      //                     child: Text("اعلن هنا".tr()),
      //                   ),
      //                 ))
      //           ],
      //         ),
      //       );
      //
      //
      //
      //
      //
      //
      //     }
      //   )
      // ),
    );
  }
}
