// // ServiceModel
//
// // Services
//
// // Services
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toordor/const/new_url_links.dart';
// import 'package:toordor/model/service_employee.dart';
// import 'package:toordor/model/services_modle.dart';
// import 'package:toordor/network/remote/api_request.dart';
// import 'package:toordor/view/block/cubit/services_state.dart';
//
//
// class ServicesCubit extends Cubit<ServicesState> {
//   ServicesCubit() : super(ServicesInitial());
//
//   static ServicesCubit get(context) => BlocProvider.of(context);
// // ServiceEmployeesModel
//   Future<void> getserviceEmployees({
//     String? ServiceId,
//   }) async {
//     String _token = await SharedPreferences.getInstance()
//         .then((value) => value.getString('token') ?? '');
//     emit(ServicesEmployeesLoading());
//     // "service_name":"sdccs","from":"2:00"
//
//     ApiRequest.getData(
//         url: ApiLinks.serviceEmploy + '$ServiceId', token: _token, path: '')
//         .then((value) {
//       if (value.statusCode == 200) {
//         ServiceModelEmployee ServicesEmployeesData =
//         ServiceModelEmployee.fromJson(value.data);
//         emit(ServicesEmployeesSuccess(ServicesEmployeesData));
//       }
//     }).catchError((Error) {
//       emit(ServicesEmployeesError("الرجاء التحقق من البيانات"));
//     });
//   }
//
//   Future<void> getserviceIndex() async {
//     String _token = await SharedPreferences.getInstance()
//         .then((value) => value.getString('token') ?? '');
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? _busuneesId = sharedPreferences.getString('busineesId');
//     emit(ServicesIndexLoading());
//     // "service_name":"sdccs","from":"2:00"
//
//     ApiRequest.getData(
//         url: ApiLinks.serviceIndex + _busuneesId!, token: _token, path: '')
//         .then((value) {
//       if (value.statusCode == 200) {
//         servicesData = ServiceModel.fromJson(value.data);
//         // print(servicesData!.data![0].serviceName);
//         emit(ServicesIndexSuccess());
//       }
//     }).catchError((Error) {
//       emit(ServicesIndexError("الرجاء التحقق من البيانات"));
//     });
//   }
//
//   ServiceModel? servicesData;
// }