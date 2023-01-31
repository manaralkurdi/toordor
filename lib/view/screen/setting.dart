




import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toordor/view/block/cubit_local/locale_cubit.dart';
import 'dart:ui' as ui;

import 'package:toordor/view/screen/home_page.dart';
class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String translate = "";
  late SharedPreferences prefs;
  save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('StringTranslate', translate);
  }
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    String translate = prefs.getString('StringTranslate') ?? "";
    print(translate);
  }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar2(context:context),
      body: Center(
        child: Container(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("تغيير اللغة".tr(),style: TextStyle(fontSize: 14),),
              Wrap(
                children: translator.locals().map((i) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () async {
                            translate=i.languageCode;
                            prefs = await SharedPreferences.getInstance();
                            prefs.setString('StringTranslate', translate);
                            print(prefs.getString('StringTranslate'));
                            print( i.languageCode);
                            context.read<LocaleCubit>().changeLanguage(i.languageCode);
                            translator.setNewLanguage(
                              context,
                              newLanguage: i.languageCode,
                              remember: true,
                              restart: false,
                            );
                          },
                          child: Text(i.languageCode),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              // DropdownButton(
              //   underline: Container(),
              //   onChanged: (v) => setState(() {
              //     translator.setNewLanguage(
              //       context,
              //       newLanguage: translator.currentLanguage == 'he' ? 'he' :'ar',
              //       remember: false,
              //       restart: true,
              //     );
              //     translate=translator.currentLanguage;
              //     print(translate);
              //     print(translator.currentLanguage);
              //     save();
              //   }),
              //   hint: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //         translator.currentLanguage == 'he'  ? "اللغة".tr() : "اللغة"),
              //   ),
              //   //   value: AppLocalizations.of(context)!.locale.toString(),
              //   // change this line with your way to get current locale to
              //   // select it as default in dropdown
              //   items: [
              //     DropdownMenuItem(
              //         child: Text(  translator.currentLanguage == 'he' ?
              //         'التحويل الى العربية'.tr():'التحويل الى العبرية'),
              //         value:  translator.currentLanguage
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
