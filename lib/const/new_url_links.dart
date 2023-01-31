class ApiLinks {
  ///base url
  static const String domain = 'https://toordor.com/api/';

  ///auth
  static const String register = '${domain}register'; //POST
  static const String sendOTP = '${domain}send-otp'; //POST
  static const String sendOTPRegister = '${domain}register/send-otp'; //POST
  static const String login = '${domain}login'; //POST
  ///index
  static const String index = '${domain}categories';
  static const String busineesIndex = '${domain}businees-index/'; //add id
  static const String serviceIndex = '${domain}service-index/'; //add id
  static const String serviceEmploy = '${domain}services/'; //add id
  ///busineesCreate
  static const String busineesCreate = '${domain}businees/create';
  static const String busineesGet = '${domain}businees/get';
  static const String busineesRequestSend = '${domain}businees/request/send';
  static const String busineesAppointments = '${domain}businees/appointments';
  static const String busineesServices = '${domain}businees/services';
  static const String busineesEmployees = '${domain}businees/employees';
  static const String busineesupdate = '${domain}businees/update';
  static const String busineescancelappointment = '${domain}businees/appointments/cancel';
  static const String busineesAppointmentsCancel =
      '${domain}businees/appointments/cancel';
  static const deleteAccount='${domain}user/account/delete';
  static const  search = '${domain}search';

  ///Employee
 // static const String sendOTP = '${domain}send-otp'; //POST
  static const String verifyOTPregister = '${domain}register/verify-otp'; //POST
   static const String verifyOTP = '${domain}verify-otp'; //POST
   static const String resetPassword = '${domain}password-reset'; //POST
  static const String employeeDays = '${domain}employee/days'; //POST
  static const String employeeAppointments = '${domain}employee/appointments';
  static const String createEmployee =
      '${domain}employee/create'; //ممكن في غلط في اللينك
  static const String employeeRequestShow = '${domain}employee/request/show';
  static const String employeeRequestNumber =
      '${domain}employee/request/number';
  static const String employeeRequestAccept =
      '${domain}employee/request/accept';
  static const String employeeRequestRefuse =
      '${domain}employee/request/refuse';
  static const String employeeCreateWorkHours =
      '${domain}employee/create/workhours';

  ///App
  static const String dayDetails = '${domain}day/details';
  static const String book = '${domain}book';
  static const String bookAvilableAndNot = '${domain}user/available-reservations';
static const String bookMonth= '${domain}user/months-reservation' ;
  ///Users
  static const String user = '${domain}user';
  static const String editUser = '${domain}user/edit';
  static const String userAppoinment = '${domain}user/appoinment';
  static const String userAppoinmentCancel = '${domain}user/appoinment/cancel';
  static const String userMessage = '${domain}user/requests/show';
  static const String acceptRequestuser = '${domain}user/requests/apply';
  static const String cancelRequestuser = '${domain}api/user/requests/refuse';

//some data not fond!
//Add Services
  static const String createNewServices = '${domain}services/create';
  static const String serviceIndexById = '${domain}service-index/:id';
  static const String getServicesEmployees = '${domain}service/:id';
static const String getListFromAccseptEmployee= '${domain}employee/services/list';
  static const String sendRequest = '${domain}businees/request/send';
  static const String acceptRequest = '${domain}employee/request/accept';
  static const String cancelRequest = '${domain}employee/request/refuse';
}
