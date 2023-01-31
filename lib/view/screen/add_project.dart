import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:csc_picker/csc_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import 'package:toordor/controller/controller.dart';
import 'package:toordor/controller/size.dart';
import 'package:toordor/model/category.dart';
import 'package:toordor/model/category_model.dart';
import 'package:toordor/view/Widget/TextForm.dart';
import 'package:toordor/view/screen/home.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/screen/my_business.dart';
import 'package:toordor/view/screen/show_bussnise_appointment.dart';
import 'package:toordor/view/widget/constant.dart';
import 'package:toordor/view/widget/image.dart';

class AddProject extends StatefulWidget {
  const AddProject({Key? key}) : super(key: key);

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  TextEditingController projectName = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController specialty = TextEditingController();

  String city = '';

  String country = "";
  final _formKey = GlobalKey<FormState>();
  String category = '';
  Shared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _hasbussnise = await SharedPreferences.getInstance()
        .then((value) => value.getBool('has_bussinees') ?? false);
    print(_hasbussnise);
  }

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

  Controller controller = Controller();
  TimeOfDay? form;
  String fromText = "";
  TimeOfDay? to;
  String toText = "";
  String services = "";
  String servicesEmployee = "";
  int idServices = 0;
  String serviceName = "";
  bool select = false;
  DateTime _dateTimeTo = DateTime.now();
  DateTime _dateTimeFrom = DateTime.now();
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
    "كوافير نسائي".tr(),
  ];
  String formatTimeOfDay(TimeOfDay tod) {
    final dt = DateTime(tod.hour, tod.minute);
    final format = DateFormat.jm();
    //"6:00 AM"
    print(format);
    return format.format(dt);
  }

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
  static TimeOfDay parseTimeOfDay(String t) {
    DateTime dateTime = DateFormat("HH:mm").parse(t);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  File imageFile = File('');
  File? _image;
  String imagee = "";
  final picker = ImagePicker();
  Future<Null> _pickImage(ImageSource source, context) async {
    final pickedImage = await ImagePicker().getImage(source: source);
    imageFile = (pickedImage != null ? File(pickedImage.path) : null)!;
    if (imageFile != null) {
      //you can set your value
      setState(() {
        imageFile = (pickedImage as File?)!;
        print("print(_image);");
        final bytes = File(imageFile!.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        print("print(_image);");
        print(img64);
        print(imageFile?.path);
        //state = AppState.picked;
      });
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("ehrviyerf");
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  //this is a code get image from Gallery
  _imageFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile = (pickedImage != null ? File(pickedImage.path) : null)!;
    if (imageFile != null) {
      setState(() {
        imageFile = (pickedImage as File?)!;
        print("print(_image);");
        final bytes = File(_image!.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        print("print(_image);");
        print(img64);
        print(_image?.path);
      });
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          Navigator.of(context).pop();
        });
      }
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        Navigator.of(context).pop();
      });
    }
  }

  TimeOfDay? _selectedTime;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicked != null)
      setState(() {
        _selectedTime = timePicked;
      });

    // Conversion logic starts here
    DateTime tempDate = DateFormat("h:m").parse(_selectedTime!.hour.toString() +
        ":" +
        _selectedTime!.minute.toString());
    var dateFormat = DateFormat("hh:mm"); // you can change the format here
    print(dateFormat.format(tempDate));
    fromText = dateFormat.format(tempDate);
    print(fromText);
    // print(tempDate);
  }

  var dateFormat = DateFormat("HH:MM");
  Widget hourMinute12HCustomStyle(DateTime time1, String text) {
    return Expanded(
      child: Container(
        //height:90,
        color: Colors.white,
        child: new TimePickerSpinner(
          is24HourMode: true,
          normalTextStyle:
              TextStyle(fontSize: 16, color: ColorCustome.colorblue),
          highlightedTextStyle:
              TextStyle(fontSize: 16, color: ColorCustome.coloryellow),
          spacing: 30,
          itemHeight: 60,
          isForce2Digits: true,
          minutesInterval: 15,
          onTimeChange: (time) {
            setState(() {
              time1 = time;
              text = dateFormat.format(time1);
              // you can change the format here
              // print(dateFormat.format(time1));
              print(fromText);
            });
          },
        ),
      ),
    );
  }

  Widget displayImage() {
    if (imageFile == null) {
      return Text("No Image Selected!");
    } else {
      return Image.file(imageFile!, width: 70, height: 70);
    }
  }

  File? image;
  String image2 = '';

  void selectImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    print(selectedImage?.path);
    setState(() {
      var a = selectedImage?.path;
      image2 = a!;
    });
  }

  void selectImagesCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    print(selectedImage?.path);
    setState(() {
      var a = selectedImage?.path;
      image2 = a!;
    });
  }

  Future showDialogSheet(BuildContext context, Widget child,
      {bool? isDismissible}) {
    return showModalBottomSheet<void>(
        context: context,
        isDismissible: isDismissible != null ? isDismissible : true,
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        isScrollControlled: false,
        builder: (BuildContext context) {
          return Wrap(children: [child]);
        });
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateeeee) {
            return AlertDialog(
              title: Text("Options"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    GestureDetector(
                      child: Text("Capture Image From Camera"),
                      onTap: () {
                        setStateeeee(() {
                          _getFromCamera();
                          // _upload(imageFile);
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    GestureDetector(
                      child: Text("Take Image From Gallery"),
                      onTap: () {
                        setStateeeee(() {
                          _getFromGallery();
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Shared();
    print("fromText");
    print(fromText);
    return Mainpage(
        child: Column(
          children: [
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: ColorCustome.colorblue,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "انشئ مشروعك الخاص",
                      style: TextStyle(
                          color: ColorCustome.colorblue, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: ColorCustome.colorblue,
            ),
            Container(
              child: Container(
                height: 50,
                child: FutureBuilder<List<CategoryModel>>(
                    future: Controller.categoryy(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: category_.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: ColorCustome.colorblue),
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                            isExpanded: false,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            hint: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(services.isEmpty
                                                  ? "اختر فئة".tr()
                                                  : services),
                                            ),
                                            items: snapshot.data!
                                                .map((CategoryModel value) {
                                              return DropdownMenuItem<String>(
                                                enabled: true,
                                                onTap: () {
                                                  idServices = value.id ?? 0;
                                                  print(idServices);
                                                },
                                                value: category_[snapshot.data
                                                            ?.indexOf(value) ??
                                                        0] ??
                                                    '',
                                                child: Text(
                                                  category_[snapshot.data
                                                              ?.indexOf(
                                                                  value) ??
                                                          0] ??
                                                      '',
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? val) {
                                              setState(() {
                                                services = val ?? '';
                                                //  showServiceEmployee = true;
                                              });
                                            }))),
                              );
                            });
                      } else {
                        print(snapshot.error);
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
            Divider(
              color: ColorCustome.colorblue,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "معلومات المشروع".tr(),
                      style: TextStyle(
                        color: ColorCustome.coloryellow,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  // displayImage(),
                  InkWell(
                    child: Container(
                      child: Column(
                        children: [
                          //this is a container that contain image
                          //when user select image from Gallery or Camera
                          Container(
                            //  margin: EdgeInsets.only(top: 20),
                            width: 70,
                            height: 70,
                            child: imageFile == File('')
                                ? Image.asset("assets/exit.png",
                                    width: 70, height: 70)
                                : Image.file(imageFile, width: 70, height: 70),
                          ),

                          //this is used to perform uploading task
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        showDialogSheet(
                            context,
                            ImagePickerDialog(
                              onCameraPressed: () {
                                _getFromCamera();
                              },
                              onGalleryPressed: () {
                                _getFromGallery();
                              },
                            ));
                      });
                    },
                  ),

                  TextForm(
                      hint: 'اسم المشروع'.tr(),
                      controller: projectName,
                      //   icon: Container(),
                      keyBoardType: TextInputType.text),
                  TextForm(
                      hint: 'رقم الهاتف'.tr(),
                      //   icon: Container(),
                      controller: phoneNumber,
                      keyBoardType: TextInputType.phone),
                  TextForm(
                      hint: 'البريد الالكتروني'.tr(),
                      controller: email,
                      //               TextForm(hint: 'التخصص'.tr(), controller: specialty)
                      //   icon: Container(),
                      keyBoardType: TextInputType.text),
                  TextForm(
                      hint: 'التخصص'.tr(),
                      controller: specialty,
                      //   icon: Container(),
                      keyBoardType: TextInputType.text),
                  Divider(
                    color: ColorCustome.colorblue,
                  ),
                  Container(
                    child: Text(
                      "الوقت".tr(),
                      style: TextStyle(
                        color: ColorCustome.coloryellow,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  // <-- for border radius
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(30.0)),
                                ),
                                // isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setStateeeee) {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(29.0),
                                          topRight: Radius.circular(29.0)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: ColorCustome.colorblue,
                                              width: 6,
                                            ),
                                          ),
                                        ),

                                        // color: Colors.white,
                                        // height: 300,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "الوقت".tr(),
                                                      style: TextStyle(
                                                        color: ColorCustome
                                                            .coloryellow,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Divider(
                                                  color: ColorCustome.colorblue,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  //  hourMinute12HCustomStyle(),
                                                  Expanded(
                                                    child: InkWell(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20.0,
                                                                right: 20,
                                                                top: 10),
                                                        child: Center(
                                                          child: Text(
                                                            "من",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        color: ColorCustome
                                                            .colorblue,
                                                      ),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              //  title: Text("Alert Dialog"),
                                                              content:
                                                                  hourMinute12HCustomStyle(
                                                                      _dateTimeFrom,
                                                                      fromText),
                                                              actions: [
                                                                TextButton(
                                                                  child: Text(
                                                                      "Close"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 12.0),
                                                      child: InkWell(
                                                        child: Container(
                                                          child: Center(
                                                            child: Text(
                                                              "الى",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20.0,
                                                                  right: 20,
                                                                  top: 10),
                                                          color: ColorCustome
                                                              .colorblue,
                                                        ),
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                //  title: Text("Alert Dialog"),
                                                                content:
                                                                    hourMinute12HCustomStyle(
                                                                        _dateTimeTo,
                                                                        toText),
                                                                actions: [
                                                                  TextButton(
                                                                    child: Text(
                                                                        "Close"),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "اختيار ايام العطلة".tr(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: ColorCustome
                                                              .coloryellow),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Divider(
                                                  color: ColorCustome.colorblue,
                                                ),
                                              ),
                                              Container(
                                                height: 100,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: weekdays.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setStateeeee(
                                                                    () {
                                                                  print(weekdays[
                                                                      index]);
                                                                  weekdays_selectuser.contains(weekdays[
                                                                              index]) ==
                                                                          true
                                                                      ? weekdays_selectuser.remove(
                                                                          weekdays[
                                                                              index])
                                                                      : weekdays_selectuser.add(
                                                                          weekdays[
                                                                              index]);
                                                                  print(
                                                                      weekdays_selectuser);
                                                                });
                                                              },
                                                              child: Container(
                                                                height: 30,
                                                                width: 90,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: ColorCustome
                                                                          .colorblue),
                                                                  color: weekdays_selectuser.contains(weekdays[
                                                                              index]) ==
                                                                          true
                                                                      ? ColorCustome
                                                                          .colorblue
                                                                      : Colors
                                                                          .white,
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                  weekdays[
                                                                      index],
                                                                  style: TextStyle(
                                                                      color: ColorCustome
                                                                          .coloryellow,
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    }),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 12.0),
                                                child: InkWell(
                                                  child: Container(
                                                    child: Center(
                                                      child: Text(
                                                        "حفظ",
                                                        style: TextStyle(
                                                            color: ColorCustome
                                                                .coloryellow,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20.0,
                                                            right: 20,
                                                            top: 10),
                                                    //  color:Colors.white,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: ColorCustome
                                                                .colorblue)),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorCustome.colorblue)),
                                child: Center(
                                  child: Text(
                                    "اوقات العمل",
                                    style: TextStyle(
                                      color: ColorCustome.coloryellow,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: 90,
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20,
                            ),
                            decoration: BoxDecoration(
                                color: ColorCustome.colorblue,
                                border:
                                    Border.all(color: ColorCustome.colorblue)),
                            child: Center(
                              child: Text(
                                "حفظ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                // <-- for border radius
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(30.0)),
                              ),

                              // isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setStateeeee) {
                                  return ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(29.0),
                                        topRight: Radius.circular(29.0)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            color: ColorCustome.colorblue,
                                            width: 6,
                                          ),
                                        ),
                                      ),

                                      // color: Colors.white,
                                      height: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Text(
                                                "انشاء المشروع".tr(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Divider(
                                              color: ColorCustome.colorblue,
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text("الفئة".tr()),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(":"),
                                                  ),
                                                  Text(services.toString()),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: ColorCustome.colorblue,
                                            ),
                                            Container(
                                              child: Text(
                                                "معلومات المشروع".tr(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'اسم المشروع'.tr(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(":"),
                                                  ),
                                                  Text(
                                                    projectName.text.toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: ColorCustome
                                                            .colorblue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'رقم الهاتف'.tr(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(":"),
                                                  ),
                                                  Text(
                                                    phoneNumber.text.toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: ColorCustome
                                                            .colorblue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'التخصص'.tr(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(":"),
                                                  ),
                                                  Text(
                                                    specialty.text.toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: ColorCustome
                                                            .colorblue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'البريد الالكتروني'.tr(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(":"),
                                                  ),
                                                  Text(
                                                    email.text.toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: ColorCustome
                                                            .colorblue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: ColorCustome.colorblue,
                                            ),
                                            Container(
                                              child: Text(
                                                "الوقت".tr(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'من'.tr(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(":"),
                                                  ),
                                                  Text(
                                                    fromText.toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: ColorCustome
                                                            .colorblue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'الى'.tr(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(":"),
                                                  ),
                                                  Text(
                                                    toText.toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: ColorCustome
                                                            .colorblue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: ColorCustome.colorblue,
                                            ),
                                            Container(
                                              child: Text(
                                                'ايام العطلة'.tr(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    weekdays_selectuser
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: ColorCustome
                                                            .colorblue),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              child: Container(
                                                width: 90,
                                                padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  right: 20,
                                                ),
                                                decoration: BoxDecoration(
                                                    color:
                                                        ColorCustome.colorblue,
                                                    border: Border.all(
                                                        color: ColorCustome
                                                            .colorblue)),
                                                child: Center(
                                                  child: Text(
                                                    "حفظ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                print(fromText);
                                                print(toText);
                                                if (email.text.isEmpty ||
                                                    projectName.text.isEmpty ||
                                                    phoneNumber.text.isEmpty ||
                                                    fromText.isEmpty ||
                                                    toText.isEmpty ||
                                                    weekdays.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        ' الرجاء كتابة كافة المعلومات'
                                                            .tr()),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ));
                                                } else {
                                                  controller.insertBusiness(
                                                    context,
                                                    city: "",
                                                    country: "",
                                                    email: email.text,
                                                    nameProject:
                                                        projectName.text,
                                                    phoneNumber:
                                                        phoneNumber.text,
                                                    specialization:
                                                        specialty.text,
                                                    fromt: fromText,
                                                    id: idServices,
                                                    tot: toText,
                                                    weekend: weekdays_selectuser
                                                        .toString(),
                                                  );
                                                  // ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                                                  //     content: Text(' تمت الاضافة بنجاح  '.tr())));
                                                  // Controller.navigatorGo(context, ShowBussniseAppointment());
                                                }
                                                ;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        childfloat: Container());
    // return  Scaffold(
    //   appBar: AppBar2(context:context),
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         // Container(
    //         //   // child: const SizedBox(width: 300),
    //         //   height: 50,
    //         //   width: 150,
    //         //   decoration: const BoxDecoration(
    //         //     image: DecorationImage(
    //         //       fit: BoxFit.fitWidth,
    //         //       image: AssetImage(
    //         //           'assets/1f3b82a8-489f-4051-9605-90fc99c2010a-removebg-preview.png'),
    //         //     ),
    //         //   ),
    //         // ),
    //         Container(
    //           height: 50,
    //           width:300,
    //           child: FutureBuilder<List<CategoryModel>>(
    //               future: Controller.categoryy(context),
    //               builder: (context, snapshot) {
    //                 if (snapshot.hasData) {
    //                   return ListView.builder(
    //                     itemCount:category_.length,
    //                     itemBuilder: (context,index) {
    //                       return Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Container(
    //                             height: 50,
    //                             width:500,
    //                             decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(3),
    //                                 color: Colors.grey[300]),
    //                             child: DropdownButtonHideUnderline(
    //                                 child: DropdownButton(
    //                                     hint: Padding(
    //                                       padding: const EdgeInsets.all(8.0),
    //                                       child: Text(
    //                                           services.isEmpty ? "اختر فئة".tr() : services),
    //                                     ),
    //                                     items: snapshot.data!.map((CategoryModel value) {
    //                                       return DropdownMenuItem<String>(
    //                                         enabled: true,
    //                                         onTap: () {
    //                                           idServices = value.id??0;
    //                                           print(idServices);
    //
    //                                         },
    //                                         value: category_[snapshot.data?.indexOf(value)??0]?? '',
    //                                         child: Text(
    //                                           category_[snapshot.data?.indexOf(value)??0]?? '',
    //                                         ),
    //                                       );
    //                                     }).toList(),
    //                                     onChanged: (String? val) {
    //                                       setState(() {
    //                                         services =val??'';
    //                                       //  showServiceEmployee = true;
    //                                       });
    //                                     }))),
    //                       );
    //                     }
    //                   );
    //                 } else {
    //                   print(snapshot.error);
    //                   return const Center(child: CircularProgressIndicator());
    //                 }
    //               }),
    //         ),
    //         SizedBox(height: 20.sp),
    //
    //         Form(
    //           key: _formKey,
    //           child: Column(
    //             children: [
    //               Container(
    //                   child: TextForm(hint: 'اسم المشروع'.tr(),
    //                       controller: projectName)),
    //               TextForm(hint: 'رقم الهاتف'.tr(), controller: phoneNumber),
    //               TextForm(hint: 'البريد الالكتروني'.tr(), controller: email),
    //               TextForm(hint: 'التخصص'.tr(), controller: specialty),
    //             ],
    //           ),
    //         ),
    //
    //         Text("اختيار ايام العطلة".tr(),style: TextStyle(fontSize: 14),),
    //         Container(
    //           height: 100,
    //           child: ListView.builder(
    //               scrollDirection: Axis.horizontal,
    //               itemCount: weekdays.length,
    //               itemBuilder: (context, index) {
    //                 return Column(
    //                   children: [
    //                     Padding(
    //                       padding:
    //                       const EdgeInsets.all(8.0),
    //                       child: InkWell(
    //                         onTap: () {
    //                           setState(() {
    //                             print(weekdays[index]);
    //                             weekdays_selectuser.contains(
    //                                 weekdays[index]) ==
    //                                 true
    //                                 ?  weekdays_selectuser
    //                                 .remove(weekdays[index])
    //                                 : weekdays_selectuser
    //                                 .add(weekdays[index]);
    //                             print(weekdays_selectuser);
    //                           });
    //                         },
    //                         child: Container(
    //                           height: 30,
    //                           width: 90,
    //                           decoration: BoxDecoration(
    //                             border: Border.all(),
    //                             color: weekdays_selectuser
    //                                 .contains(
    //                                 weekdays[
    //                                 index]) ==
    //                                 true
    //                                 ? Colors.blue
    //                                 : Colors.white,
    //                           ),
    //                           child: Center(
    //                               child: Text(
    //                                   weekdays[index])),
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 );
    //               }),
    //         ),
    //          Text('اوقات العمل'.tr()),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Container(
    //               width: 70,
    //               child: FloatingActionButton(
    //                 heroTag: "hero1",
    //                   child: Center(child: Padding(
    //                     padding: const EdgeInsets.all(8.0),
    //                     child: Text(fromText.isEmpty ? 'من'.tr() : fromText),
    //                   )),
    //                   onPressed: () async {
    //                     _selectTime(context);
    //                   }),
    //             ),
    //             SizedBox(width: MySize.width(context) / 3),
    //             FloatingActionButton(
    //                 heroTag: "hero2",
    //                 child: Text(toText.isEmpty ? 'الى'.tr() : toText),
    //                 onPressed: () async => await showTimePicker(
    //                         context: context,
    //                         initialTime: to ?? TimeOfDay.now())
    //                     .then((value) => setState(() =>
    //                 toText =
    //                         '${value?.hour ?? 0}:${value?.minute??0} '))),
    //           ],
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0,right: 20),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               form != null ? Text('$fromText') : Text("من".tr()),
    //               to != null ? Text('$toText') : Text("الى".tr()),
    //             ],
    //           ),
    //         ),
    //         SizedBox(height: MySize.height(context) / 80),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: CSCPicker(
    //           //  defaultCountry: DefaultCountry.Palestinian_Territory_Occupied,
    //             showStates: false,
    //             dropdownHeadingStyle: TextStyle(fontSize: 10),
    //             //  onStateChanged: (String? myCity)=>setState(()=>city=myCity??''),
    //             countryDropdownLabel:
    //                 country.isEmpty ? 'اختر دولتك'.tr() : country,
    //             onCountryChanged: (value) => setState(() => country = value),
    //             //onStateChanged: (String? value)=>value!=null?city=value:null,
    //             showCities: false,
    //           ),
    //         ),
    //         ElevatedButton(
    //             onPressed: () {
    //               print(fromText);
    //               print(toText);
    //               if (email.text.isEmpty||projectName.text.isEmpty||
    //                   phoneNumber.text.isEmpty||
    //               fromText.isEmpty ||toText.isEmpty||weekdays.isEmpty){
    //                 ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    //                     content: Text(' الرجاء كتابة كافة المعلومات'.tr()),
    //                     backgroundColor: Colors.green,
    //                 ));
    //               }
    //             else{
    //                 controller.insertBusiness(context,
    //                   city: "",
    //                   country: "",
    //                   email: email.text,
    //                   nameProject: projectName.text,
    //                   phoneNumber: phoneNumber.text,
    //                   specialization: specialty.text,
    //                   fromt: fromText,
    //                   id: idServices,
    //                   tot: toText,
    //                   weekend: weekdays_selectuser.toString(),)
    //                 ;
    //                 // ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    //                 //     content: Text(' تمت الاضافة بنجاح  '.tr())));
    //                // Controller.navigatorGo(context, ShowBussniseAppointment());
    //               }
    //
    //               //  Navigator.push(context, MaterialPageRoute(builder: ShowBussniseAppointment()));
    //               //  Navigator.push(context, MaterialPageRoute(builder: MyBusiness()));
    //             },
    //
    //             child:  Text("حفظ".tr()))
    //       ],
    //     ),
    //   ),
    // );
  }
}
