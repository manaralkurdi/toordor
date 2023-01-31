

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/View/Screen/home.dart';
import 'package:toordor/view/block/cubit/home_cubit.dart';
import 'package:toordor/view/block/cubit/myWorkPlace_cubit.dart';
import 'package:toordor/view/block/cubit/sendReuest_cubit.dart';
import 'package:toordor/view/screen/home_body_category.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/screen/login_screen.dart';
import 'package:toordor/view/screen/show_bussnise_appointment.dart';
import 'View/Screen/splash_screen.dart';
import 'network/remote/api_request.dart';
import 'view/block/cubit/search_cubit.dart';
import 'view/block/cubit_local/locale_cubit.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  await translator.init(
    localeType: LocalizationDefaultType.asDefined,
    languagesList: <String>['he', 'ar'],
    assetsDirectory: 'assets/lang/',
  );
  //Bloc.observer = MyBlocObserver();
  ApiRequest.init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print('Token ===   ${preferences.getString("token")}');
  bool data = preferences.getString('token') == null;

  runApp(LocalizedApp(
      child: MyApp(route: data)));
}

class MyApp extends StatelessWidget {
  //final String defaultSystemLocale = Platform.localeName;
  final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
  bool route;
  late SharedPreferences prefs;
  String bussniseid='he';
  bool hasbussnise=false;
  fetch() async {
    prefs = await SharedPreferences.getInstance();
    bussniseid = prefs.getString('StringTranslate') ?? bussniseid;
    hasbussnise = prefs.getBool("has_bussinees")??false;
    print(bussniseid);
  }
  MyApp({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller.userData(context);
    fetch();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()..getLocation(),
        ),
        BlocProvider<MyWorkPlaceCubit>(
          create: (context) => MyWorkPlaceCubit(),
        ),
        BlocProvider(create: (context) => LocaleCubit()..getSavedLanguage()),
        BlocProvider(create: (context) => SendRequestCubit(),),
        BlocProvider(create: (BuildContext context) => SearchCubit()),
        //  BlocProvider(create: (BuildContext context) => InternetBloc())
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return
             BlocBuilder<LocaleCubit, ChangeLanguageState>(
  builder: (context, state) {
    return MaterialApp(
              title: 'ToorDor',
              debugShowCheckedModeBanner: false,
              // supportedLocales: const [
              //   Locale('ar', 'EG'),
              //   Locale('en', 'US'),
              // ],
              theme: ThemeData(
                fontFamily: 'Amiri',
                scaffoldBackgroundColor: Colors.grey.shade50,
                primarySwatch: Colors.grey,
              ),
              localizationsDelegates: translator.delegates, // Android + iOS Delegates
              locale: state.locale,// Active locale
              supportedLocales: translator.locals(),
              home:
              SplashScreen(route: route ?
               LoginPage() :
              hasbussnise==false?
              HomeBodyCategory():ShowBussniseAppointment()
            )
            );
  },
);

      }),
    );
  }
}
// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(),
//       appBar: AppBar(
//         title: Text('appTitle'.tr()),
//         // centerTitle: true,
//       ),
//       body: Container(
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             SizedBox(height: 50),
//             Text(
//               'textArea'.tr(),
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 35),
//             ),
//             ElevatedButton(onPressed: () {
//       translator.setNewLanguage(
//       context,
//       newLanguage: translator.currentLanguage == 'ar' ? 'he' : 'ar',
//       remember: true,
//       restart: true,
//       );
//       }, child: Text('buttonTitle'.tr()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
