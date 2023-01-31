import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/controller/controller.dart';
import 'package:toordor/model/appointment_user.dart';
import 'package:toordor/model/category_model.dart';
import 'package:toordor/view/screen/bussnise_of_category_screen.dart';
import 'package:toordor/view/screen/calender.dart';
import 'package:toordor/view/screen/home.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/widget/constant.dart';

import 'setting_new.dart';

class HomeBodyCategory extends StatefulWidget {
  HomeBodyCategory({Key? key}) : super(key: key);

  @override
  State<HomeBodyCategory> createState() => _HomeBodyCategoryState();
}

class _HomeBodyCategoryState extends State<HomeBodyCategory> {
  Controller controller = Controller();
  ScrollController _scrollController = new ScrollController();
  late int pageCount;
  int selectedIndex = 0;
  PageController pageController = PageController();
  bool indicator = false;
  int indexPage = 0;
  int perPageItem = 8;
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  Future? cashing;
  late int lastPageItemLength;
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];
  List category_ = [
    "صالون حلاقة رجالي".tr(),
    "صالونات تجميل".tr(),
    "تصميم اظافر".tr(),
    "تعليم القيادة".tr(),
    "غسيل سيارات".tr(),
    "مدرس خاص".tr(),
    "صالات رسم الوشم".tr(),
    "مدرب شخصي".tr(),
    "علاج واستشارة طبية".tr(),
    "تصوير".tr(),
    "مدرب حيوانات".tr(),
    "مدرب سباحة".tr(),
    "تدريب الفنون".tr(),
    "كراجات وتصليح".tr(),
    "مدقق حسابات".tr(),
    "محامين".tr(),
    "ميادين الرماية".tr(),
    "عرافة".tr(),
    "علاج طبيعي/ فيزوترابيا".tr(),
    "منتجع صحي وتدليك".tr(),
    "مستشار".tr(),
    "وسيط/وكيل".tr(),
    "طبيب بيطري".tr(),
    "مطاحن".tr(),
    "مجالس محلية".tr(),
    "معاصر الزيتون".tr(),
    "طبيب اسنان".tr(),
    "قاعات الافراح والمناسبات".tr(),
    "طبيب عيون".tr(),
    "طبيب  امراض البشرة".tr(),
    "كوافير نسائي".tr()
  ];
  List<String> list = [];
  Future<dynamic> category(BuildContext context) =>
      Controller.categoryy(context);
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

  @override
  void initState() {
    pageController = PageController(initialPage: 1);
    for (int i = 1; i <= 0; i++) {
      category_.add('$i');
    }
    var num = (category_.length / perPageItem);
    pageCount = num.isInt ? num.toInt() : num.toInt() + 1;

    var reminder = category_.length.remainder(perPageItem);
    lastPageItemLength = reminder == 0 ? perPageItem : reminder;
    imageCache.clear();
    imageCache.clearLiveImages();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Mainpage(
      childfloat: Container(),
      child: SingleChildScrollView(
        child: Container(
            height: 760,
            padding: const EdgeInsets.only(right: 10, left: 12),
            child: FutureBuilder<List<CategoryModel>>(
                future: Controller.categoryy(context),
                builder: (context, snapshot) {
                  return FutureBuilder<SharedPreferences>(
                      future: SharedPreferences.getInstance(),
                      builder: (context, snapshot) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset(
                                  'assets/user.png',
                                  height: 50.0,
                                  width: 50.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                height: 30,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${snapshot.data?.getString('fullname') ?? ""}",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        "welcome".tr(),
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 200,
                                child: PageView.builder(
                                    itemCount: 2,
                                    pageSnapping: true,
                                    itemBuilder: (context, pagePosition) {
                                      return Container(
                                          margin: EdgeInsets.all(10),
                                          child: Image.network(
                                              images[pagePosition]));
                                    }),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, left: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "مواعيد اليوم",
                                      style: TextStyle(
                                          color: ColorCustome.colorblue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Calender()));
                                      },
                                      child: Container(
                                        child: Text(
                                          "الكل",
                                          style: TextStyle(
                                              color: ColorCustome.colorblue,
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                child: FutureBuilder<List<AppointmentUser>>(
                                    future: Controller.userAppointment(context),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&snapshot.connectionState==ConnectionState.waiting&&
                                          snapshot.data != []) {
                                        return ListView.builder(
                                            physics: ScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: 2,
                                            itemBuilder: (context, index) {
                                              var datenow = DateTime.now();
                                              var dateTime = DateTime.parse(datenow.toString());
                                              var format1 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
                                              print(format1);
                                              if (snapshot.hasData&&
                                                  snapshot.data != []) {
                                                return Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      height: 50,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: ColorCustome
                                                                .colorblue,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              12)),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.only(left: 6.0,right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text('${snapshot.data?[index].service?.serviceName ?? ""}',style: TextStyle(
                                                                    fontSize: 12,color: Colors.black
                                                                ),),
                                                                Row(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Text('${snapshot.data?[index].fromDate ?? ""}',
                                                                      style: TextStyle(color: ColorCustome.coloryellow,fontSize: 12)
                                                                      ,),
                                                                    Text("-", style: TextStyle(color: ColorCustome.coloryellow,fontSize: 12)),
                                                                    Text('${snapshot.data?[index].toDate ?? ""}', style: TextStyle(color: ColorCustome.coloryellow,fontSize: 12)),
                                                                  ],
                                                                ),
                                                                Text('${snapshot.data?[index].bussnise?.BussniseName ?? ""}',style: TextStyle(
                                                                    fontSize: 12,color: Colors.black)),
                                                              ],
                                                            ),
                                                            ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  20), // Image border
                                                              child: SizedBox
                                                                  .fromSize(
                                                                size: Size.fromRadius(
                                                                    40), // Image radius
                                                                child:
                                                                Image.asset(
                                                                  "assets/1900.jpg",
                                                                  height: 80,
                                                                  width: 90,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            // Column(
                                                            //   children: [
                                                            //     Container(
                                                            //       child: Image.asset(""),
                                                            //     )
                                                            //   ],
                                                            // )
                                                          ],
                                                        ),
                                                      )),
                                                );
                                              } else {
                                                return Container(
                                                  child: Center(
                                                    child: Text("لايوجداي مواعيد".tr(),style: TextStyle(
                                                        color: Colors.black,fontSize: 12
                                                    ),),
                                                  ),
                                                );
                                              }
                                            });
                                      } else {
                                        return Container(
                                          child: Center(
                                            child: Text("لايوجداي مواعيد".tr(),style: TextStyle(
                                                color: Colors.black,fontSize: 12
                                            ),),
                                          ),
                                        );
                                        //   Center(
                                        //   child: Text("لايوجد اي مواعيد".tr()),
                                        // );
                                      }
                                    }),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 8.0, left: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text("اختيار الخدمة",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: ColorCustome.colorblue,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 270,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 270,
                                        child:
                                            FutureBuilder<List<CategoryModel>>(
                                                future: Controller.categoryy(
                                                    context),
                                                builder: (context, snapshot) {
                                                  print(snapshot.data?.length);
                                                  var num =
                                                      (snapshot.data?.length ??
                                                          0 / perPageItem);
                                                  pageCount = num.isInt
                                                      ? num.toInt()
                                                      : num.toInt() + 1;
                                                  late int? reminder = snapshot
                                                          .data?.length
                                                          .remainder(
                                                              perPageItem) ??
                                                      0;
                                                  lastPageItemLength =
                                                      reminder == 0
                                                          ? perPageItem
                                                          : reminder;

                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.none) {
                                                    return Center(
                                                        child: Text(
                                                            'لا يتوافر اتصال بالانترنت'
                                                                .tr()));
                                                  } else if (snapshot.hasData) {
                                                    return GridView.builder(
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 2,
                                                          mainAxisSpacing: 1,
                                                        ),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: snapshot
                                                                .data?.length ??
                                                            0,
                                                        shrinkWrap: false,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Column(
                                                              children: [
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      print(snapshot
                                                                              .data?[index]
                                                                              .id ??
                                                                          0);
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => HomeBody1(snapshot.data?[index].id ?? 0)));
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              0.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(20), // Image border
                                                                              child: SizedBox.fromSize(
                                                                                size: Size.fromRadius(50), // Image radius
                                                                                child: CachedNetworkImage(
                                                                                  fit: BoxFit.fill,
                                                                                  imageUrl: snapshot.data?[index].image ?? "",
                                                                                  maxWidthDiskCache: 200,
                                                                                  //   memCacheHeight: 200,
                                                                                  // maxHeightDiskCache: 200,
                                                                                  memCacheWidth: 190,

                                                                                  // images[index].toString()
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // Container(
                                                                          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                                                          //   child: CachedNetworkImage(
                                                                          //     fit: BoxFit.fill,
                                                                          //     imageUrl: snapshot.data?[index].image ?? "",
                                                                          //     height: 100,
                                                                          //     width: 150,
                                                                          //
                                                                          //     maxWidthDiskCache: 150,
                                                                          //     //   memCacheHeight: 200,
                                                                          //     // maxHeightDiskCache: 200,
                                                                          //     memCacheWidth: 190,
                                                                          //
                                                                          //     // images[index].toString()
                                                                          //   ),
                                                                          // ),
                                                                          // //          Container(
                                                                          // //            height: 40,width: 60,
                                                                          // //            decoration:BoxDecoration(
                                                                          // //              borderRadius: BorderRadius.circular(20),
                                                                          // //              color: Colors.blue
                                                                          // // ),
                                                                          // //            child: Image(
                                                                          // // image:AssetImage(images?[index]??""),
                                                                          // //              fit: BoxFit.cover,height:40,width: 60,),
                                                                          // //          ),
                                                                          //       ),

                                                                          // Container(
                                                                          //   width: 50,
                                                                          //   height: 60,
                                                                          //   decoration:  BoxDecoration(
                                                                          //     borderRadius: BorderRadius.circular(10),
                                                                          //
                                                                          //   ),
                                                                          //
                                                                          //   child: Padding(
                                                                          //     padding: const EdgeInsets.only(top: 8.0,bottom: 10),
                                                                          //     child:
                                                                          //     Image.network(
                                                                          //       snapshot.data?[index].image.toString()??"",
                                                                          //       height: 30,
                                                                          //       width: 30,
                                                                          //     ),
                                                                          //   ),
                                                                          // ),
                                                                          //   margin: const EdgeInsets.all(5),
                                                                          //   padding: const EdgeInsets.all(9),
                                                                          //   alignment: Alignment.topCenter,
                                                                          //   child: null,
                                                                          // ),

                                                                          Container(
                                                                            child:
                                                                                Text(
                                                                              '${category_?[index].toString()}',
                                                                              // snapshot.data['data'][index]['name']!
                                                                              //     .toString(),
                                                                              style: const TextStyle(color: Colors.black, fontSize: 11),
                                                                              overflow: TextOverflow.visible,
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ))
                                                              ]);
                                                        });
                                                  } else {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                }),
                                      ),
                                    ],
                                  ))
                            ]);
                      });
                })),
      ),
    );
  }
}
