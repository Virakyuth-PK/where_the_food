// import 'package:where_the_food/app/models/response/user/user_model.dart';
//
// import '../../../models/response_role/response_role.dart';
// import '../../../models/response_user/response_user.dart';
// import '../../../utils/service.dart';
// import '../manager/db_manager.dart';
//
// convertUserJson(UserModel data) {
//   return UserModel(
//     displayName: data.displayName!,
//     userId: data.userId!,
//     accessToken: data.accessToken!,
//     pagingSize: data.pagingSize!,
//     refreshToken: data.refreshToken!,
//     userRole: data.roles!.join(","),
//   );
// }
//
// convertUserMoor(User data) async {
//   var listRole = await locator<AppDatabase>().getRole();
//   var listResponseRole = <ResponseRole>[];
//   for (var item in listRole) {
//     listResponseRole.add(convertUserMoor(item));
//   }
//   return ResponseUser(
//       refreshToken: data.refreshToken,
//       pagingSize: data.pagingSize,
//       accessToken: data.accessToken,
//       displayName: data.displayName,
//       roles: listResponseRole,
//       userId: data.userId);
// }
