import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:toordor/Controller/Controller.dart';
import 'package:toordor/Controller/size.dart';
import 'package:toordor/model/services_bussnise.dart';
import 'package:toordor/view/block/cubit/search_cubit.dart';
import 'package:toordor/view/block/cubit/sendReuest_cubit.dart';
//import 'package:toordor/View/block/cubit/search_cubit.dart';
import 'package:toordor/model/search_model.dart';
import 'package:toordor/view/block/state/Search_state.dart';
import 'package:toordor/view/screen/home_page.dart';
import 'package:toordor/view/screen/my_work_place.dart';
import 'package:toordor/view/screen/show_bussnise_appointment.dart';
import 'package:toordor/view/widget/slide_page_transitions.dart';

import 'package:toordor/view/block/state/sendRequest_satate.dart';

import '../Widget/TextForm.dart';

class MyEmployees extends StatefulWidget {
  MyEmployees({Key? key}) : super(key: key);

  @override
  State<MyEmployees> createState() => _MyEmployeesState();
}

class _MyEmployeesState extends State<MyEmployees> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    var message= new TextEditingController();
    var searchController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar:AppBar2(context:context),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: searchController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "يحب ادخل النص".tr();
                      }
                    },
                    onFieldSubmitted: (String text) {
                      if (text.isEmpty) {
                         "يحب ادخال رقم الهاتف".tr();
                      }
                      SearchCubit.get(context)
                          .search(mobileNumber: searchController.text);
                    },
                    onChanged: (v){
                      SearchCubit.get(context)
                          .search(mobileNumber: searchController.text);
                    },
                    decoration: InputDecoration(
                      enabled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      suffixIcon: InkWell(
                        onTap: () {
                          searchController.clear();
                          SearchCubit.get(context)
                              .search(mobileNumber: "");
                        },
                        child: const Icon(Icons.close),
                      ),
                      prefixIcon: InkWell(
                        onTap: () {
                          print(searchController.text);
                          SearchCubit.get(context)
                              .search(mobileNumber: searchController.text);
                        },
                        child: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),

                BlocConsumer<SearchCubit, SearchState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is SearchSuccess) {
                        if (searchController.text.isEmpty) {
                          "يحب ادخال رقم الهاتف".tr();
                        }
                        else{
                          return SearchResult(
                              serachData: state.searchModel);
                        }

                      }
                      if (state is SearchError) {
                        return Text(state.error);
                      } else {
                        return  Text('يرجى ادخال رقم الهاتف للبحث'.tr());
                      }
                    }),

                const Divider(height: 2),

                // FutureBuilder(
                //   future: Controller.fetchTreatsTypes(context),
                //   builder: (context, snapshot) {
                //     return const SizedBox();
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
   SearchResult({Key? key, required this.serachData})
      : super(key: key);

  final SearchModel serachData;

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String service="";

  int idServices = 0;
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
     return SizedBox(
       height: MySize.height(context),
       child: Padding(
         padding: const EdgeInsets.all(15.0),
         child: widget.serachData.success!=false
             ? Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   FutureBuilder<dynamic>(
                       future: Controller.userData(context),
                       builder: (context,userData) {
                         if (userData.hasData) {
                           return FutureBuilder<List<ServicesBussnise>>(
                               future: Controller.ServicesBussnises(
                                   context,
                                   bussniseid: userData.data['message']['bussinees_id'] ?? 0),
                               builder: (context, snapshot) {
                                 if (snapshot.hasData) {
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
                                                   child: Text(
                                                       service.isEmpty ? "اختر الخدمة" .tr(): service),
                                                 ),
                                                 items: snapshot.data!.map((value) {
                                                   return DropdownMenuItem(
                                                     enabled: true,
                                                     onTap: () => idServices = value.id ?? 1,
                                                     value: value.serviceName,
                                                     child: Text(
                                                       value.serviceName ?? '',
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
                                   print(snapshot.error);
                                   return const Center(child: CircularProgressIndicator());
                                 }
                               });
                         } else {
                           print("jjjjj");
                           return const Center(child: CircularProgressIndicator());
                         }
                       }

                   ),
                   Container(
                     height: 180,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           //employee name
                           Text(
                             widget.serachData.message?.fullname??'',
                             style: const TextStyle(
                               fontSize: 16,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           Text(
                             ' ${widget.serachData.message!.phone}',
                             style: const TextStyle(
                               fontSize:15,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           TextForm(hint: "ارسال رسالة للموظف".tr() ,controller:message),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               TextButton(
                                 onPressed: () {
                                   print(widget.serachData.message?.id?.toString());
                                   print(message.text);
                                   if(message.text.isEmpty){
                                     ScaffoldMessenger.of(context)
                                         .showSnackBar( SnackBar(content: Text('يرجى كتابة رسالة للموظف'.tr())));
                                   }
                                   else{
                                     SendRequestCubit.get(context).sendRequest(
                                         context: context,
                                         userId:
                                         widget.serachData.message?.id,
                                         message: message,
                                         serviceid: idServices
                                     );
                                   }

                                 },
                                 child: Container(
                                   height: 30,
                                   width: 105,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(8),
                                     color: Colors.blue[300],
                                   ),
                                   child:  Text(
                                     'ارسال الطلب'.tr(),
                                     style: TextStyle(
                                       color: Colors.black,
                                       fontWeight: FontWeight.w400,
                                     ),
                                   ),
                                 ),
                               ),
                               const SizedBox(
                                 width: 35,
                               ),
                               //employee id

                             ],
                           ),
                         ],
                       ),
                     ),
                   ),
                 ],
               )
             :  Center(
                 child: Text(
                   'الرجاء التحقق من رقم الهاتف '.tr(),
                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
       ),
     );
  }
}


