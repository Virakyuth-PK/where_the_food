// import 'package:logger/logger.dart';
// import 'package:where_the_food/app/models/request/login/login_model.dart';
// import 'package:where_the_food/app/models/response/user/user_model.dart';
// import '../../utils/service.dart';
// import '../local/manager/db_manager.dart';
// import 'api_url.dart';
// import 'app_dio.dart';
//
// class ApiService {
//   var apiBaseUrl = productionBaseUrl;
//
//   Future<void> login(
//       {required Function(UserModel responseData) onSuccess,
//       required LoginModel requestData,
//       Function(dynamic error)? onError}) async {
//     try {
//       await AppDio.dio()
//           .post(apiBaseUrl + loginPath, data: requestData)
//           .then((res) async {
//         //write data
//         var resultUser = UserModel.fromJson(res.data);
//         await locator<AppDatabase>().insertUser(convertUserJson(resultUser));
//         writeUserId(resultUser.userId);
//         writeToken("Bearer " + resultUser.accessToken.toString());
//         return await onSuccess(resultUser);
//       }).catchError((error) => onError!(error));
//     } catch (error, stacktrace) {
//       Logger().e("Exception occurred: $error stackTrace: $stacktrace");
//     }
//   }
// }
