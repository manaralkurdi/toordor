String baseUrl='http://toordor.com/';

//LOGIN
String authLogin='${baseUrl}api/Auth/login';//POST

// Businesses
String businesses='${baseUrl}api/TD02/Businesses';
String getBusinesses='$businesses/GetAll';//GET
String addBusinesses='$businesses/Insert';//POST
String updateBusinesses='$businesses/Update';//POST

// BusiRequists
String busiRequists='${baseUrl}api/td02/BusiRequists';
String getAllBusiRequists='$busiRequists/GetAll';//GET
String addBusiRequists='$busiRequists/Insert';//POST
String updateBusiRequists='$busiRequists/Update';//POST


// DiaryShifts //مواعيد
String diaryShifts='${baseUrl}api/td02/DiaryShifts';
String getAllDiaryShifts='$diaryShifts/GetAll';//GET
String addDiaryShifts='$diaryShifts/Insert';//POST
String updateDiaryShifts='$diaryShifts/Update';//POST

// Users
String users='${baseUrl}api/td02/Users';
String getUsers='$users/GetAll';//GET
String addUsers='$users/Insert';//POST
String updateUsers='$users/Update';//POST



// UsrTreatsTypes //services
String usrTreatsTypes='${baseUrl}api/td02/UsrTreatsTypes';
String getUsrTreatsTypes='$usrTreatsTypes/GetAll';//GET
String addUsrTreatsTypes='$usrTreatsTypes/Insert';//POST
String updateUsrTreatsTypes='$usrTreatsTypes/Update';//POST



//UsrWorkHours
String usrWorkHours='${baseUrl}api/td02/UsrWorkHours';
String getUsrWorkHours='$usrWorkHours/GetAll';
String addUsrWorkHours='$usrWorkHours/Insert';
String updateUsrWorkHours='$usrWorkHours/Update';