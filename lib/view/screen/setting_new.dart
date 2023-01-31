


import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/const/color.dart';
import 'package:toordor/view/screen/add_project.dart';
import 'package:toordor/view/screen/appointment_employee.dart';
import 'package:toordor/view/screen/help.dart';
import 'package:toordor/view/screen/home.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/logout_screen.dart';
import 'package:toordor/view/screen/my_business.dart';
import 'package:toordor/view/screen/my_employees.dart';
import 'package:toordor/view/screen/my_work_place.dart';
import 'package:toordor/view/screen/setting.dart';
import 'package:toordor/view/screen/show_employee.dart';
import 'package:toordor/view/screen/time_workplace.dart';
import 'package:toordor/view/screen/user_profile.dart';
import 'package:toordor/view/widget/constant.dart';

class SettingNew extends StatefulWidget {
  const SettingNew({Key? key}) : super(key: key);

  @override
  State<SettingNew> createState() => _SettingNewState();
}

class _SettingNewState extends State<SettingNew> {
  static List<Pages> listUser = [
    Pages(title: 'الرئيسية', page: HomeBodyCategory()),
    Pages(title: 'حسابي', page: UserProFile()),
    // Pages(title: 'اعمالي', page: MyBusiness()),
    Pages(title: 'انشئ مشروعك الخاص', page: AddProject()),
   // Pages(title: 'اوقات العمل', page: TimeWorkPlace()),
    // Pages(title: 'عروض التوظيف', page: MyEmployees()),
    Pages(title: 'طلبات التوظيف', page: MyWorkPlace()),
    Pages(title: 'اعدادات ', page: SettingPage()),
    Pages(title: 'المساعدة', page: Help()),
  ];
  static List<Pages> listBussnise = [
    Pages(title: 'الرئيسية', page: HomeBodyCategory()),
    Pages(title: 'حسابي', page: UserProFile()),
    Pages(title: 'اعمالي', page: MyBusiness()),
    //Pages(title: 'انشئ مشروعك الخاص', page: AddProject()),
   // Pages(title: 'اوقات العمل', page: TimeWorkPlace()),
    // Pages(title: 'عروض التوظيف', page: MyEmployees()),
    Pages(title: 'الموظفين'.tr(), page: ShowEmployee()),
    Pages(title: 'عروض التوظيف'.tr(), page: MyEmployees()),
    Pages(title: 'اعدادات ', page: SettingPage()),
    Pages(title: 'المساعدة', page: Help()),
  ];
  static List<Pages> listEmployee = [
    Pages(title: 'الرئيسية', page: HomeBodyCategory()),
    Pages(title: 'حسابي', page: UserProFile()),
    // Pages(title: 'اعمالي', page: MyBusiness()),
    Pages(title: 'انشئ مشروعك الخاص', page: AddProject()),
    Pages(title: 'اوقات العمل', page: TimeWorkPlace()),
    Pages(title: 'مواعيد المستخدمين', page: AppointmentEmployee()),
    Pages(title: 'طلبات التوظيف', page: MyWorkPlace()),
    Pages(title: 'اعدادات ', page: SettingPage()),
    Pages(title: 'المساعدة', page: Help()),
  ];
  late SharedPreferences prefs;
  bool bussniseid = true;
  bool isemployee = true;
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    bussniseid = prefs.getBool('has_bussinees') ?? false;
    isemployee = prefs.getBool('is_employee') ?? false;
    print("bussniseid");
    print(bussniseid);
    print(isemployee);
  }
  @override
  Widget build(BuildContext context) {
    return Mainpage(
      childfloat: Container(),
      child : FutureBuilder<dynamic>(
          future: Controller.userData(context),
          builder: (context,snapshot) {
            fetch();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: ListView.builder(
                  itemCount: bussniseid==true?listBussnise.length :isemployee==true?listEmployee.length:listUser.length,
                    itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0,left: 20),
                    child: Column(
                      children: [
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Container(
                                child: bussniseid==false?
                                Text(listUser[index].title,style:TextStyle(
                                  color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                ),)
                                    :
                                    isemployee==true?
                                    Text(listEmployee[index].title,style:TextStyle(
                                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                    ),):
                                Text(listBussnise[index].title,style:TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                                ),)
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Container(
                                  child: Icon(Icons.arrow_back_ios,color: ColorCustome.colorblue,size: 20),
                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> bussniseid==true?listBussnise[index].page:isemployee==true?listEmployee[index].page:
                            listUser[index].page));
                          },
                        ),

                      ],
                    ),
                  );
                }),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> Logout()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorCustome.colorblue,
                            ),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text("تسجيل الخروج"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      )
    );
  }
}
