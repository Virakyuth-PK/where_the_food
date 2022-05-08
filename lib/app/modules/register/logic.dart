import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:where_the_food/app/models/request/register/register_model.dart';

import '../../data/api/api.dart';
import '../../data/local/manager/db_manager.dart';
import '../../models/response/user/user_model.dart';
import '../../utils/color.dart';
import '../../utils/service.dart';
import '../../widgets/button_custom.dart';
import '../../widgets/calendar_dialog_content_custom.dart';
import '../../widgets/snack_bar_custom.dart';
import '../home/binding.dart';
import '../home/view.dart';
import 'state.dart';

class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();

  var userNameController = TextEditingController();

  var fullNameController = TextEditingController();

  var passwordController = TextEditingController();

  var isPasswordObscureText = true.obs;

  var dateController = DateRangePickerController();
  DateTime dateOfBirth = DateTime.now();
  DateTime dateOfBirthConfirmed = DateTime.now();

  String? monthDropdownValue =
      DateFormat.MMMM().format(DateTime.now()).toString();
  var yearDropdownValue = DateTime.now().year;

  var allMonth = List<String>.generate(
      12,
      (counter) => DateFormat.MMMM()
          .format(DateTime(DateTime.now().year, counter + 1))
          .toString());
  var allYear = List<String>.generate(
      (DateTime.now().year - 1950) + 1,
      (counter) =>
          DateFormat('yyyy').format(DateTime(1949 + counter + 1)).toString());
  var dateButtonClicked = false.obs;

  var userNameFocusNode = FocusNode();

  var fullNameFocusNode = FocusNode();

  var passwordFocusNode = FocusNode();

  var confirmPasswordController = TextEditingController();

  var confirmPasswordFocusNode = FocusNode();

  Future<void> onPressedRegister() async {
    if (userNameFocusNode.hasFocus) {
      userNameFocusNode.unfocus();
    }
    if (fullNameFocusNode.hasFocus) {
      fullNameFocusNode.unfocus();
    }
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus();
    }
    if (confirmPasswordFocusNode.hasFocus) {
      confirmPasswordFocusNode.unfocus();
    }
    if (userNameController.text.isEmpty) {
      snackBarCustom(
          title: 'Sorry',
          message: 'Username Empty!',
          colorText: Colors.white,
          backgroundColor: halfMainColor,
          icon: Icons.error,
          iconColor: Colors.white);
      return;
    }
    if (fullNameController.text.isEmpty) {
      snackBarCustom(
          title: 'Sorry',
          message: 'FullName Empty!',
          colorText: Colors.white,
          backgroundColor: halfMainColor,
          icon: Icons.error,
          iconColor: Colors.white);
      return;
    }
    if (passwordController.text.isEmpty) {
      snackBarCustom(
          title: 'Sorry',
          message: 'Password Empty!',
          colorText: Colors.white,
          backgroundColor: halfMainColor,
          icon: Icons.error,
          iconColor: Colors.white);
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      snackBarCustom(
          title: 'Sorry',
          message: 'Confirm Password Empty!',
          colorText: Colors.white,
          backgroundColor: halfMainColor,
          icon: Icons.error,
          iconColor: Colors.white);
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      snackBarCustom(
          title: 'Sorry',
          message: 'Password does not match!',
          colorText: Colors.white,
          backgroundColor: halfMainColor,
          icon: Icons.error,
          iconColor: Colors.white);
      return;
    }

    await Api().postRegister(
      RegisterModel(
          username: userNameController.text,
          fullName: fullNameController.text,
          dateOfBirth: DateFormat("yyyy-MM-dd").format(dateOfBirthConfirmed),
          password: passwordController.text),
      onSuccess: (UserModel data) async {
        await locator<AppDatabase>().insertUser(User.fromJson(data.toJson()));
        Get.offAll(() => HomePage(), binding: HomeBinding());
      },
    );
  }

  void onPressedDateOfBirth() {
    dateButtonClicked.value = true;
    update();

    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 350),
      context: Get.context!,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, right: 20, bottom: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomCalendarDialogContent(),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: ButtonCustom(
                                toolTip: "Cancel",
                                onPress: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Color.fromRGBO(245, 248, 249, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.comfortaa(
                                        color: Colors.black45,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              flex: 1,
                              child: ButtonCustom(
                                toolTip: "Set Date",
                                onPress: () {
                                  dateOfBirthConfirmed = dateOfBirth;
                                  update();
                                  Get.back();
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Color(0xffFF6666),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Set Date",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.comfortaa(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  onYearSelected(int value) {
    Logger().wtf(value);
    yearDropdownValue = value;
    update();
    var monthAll = List<String>.generate(
        12,
        (counter) => DateFormat.MMMM()
            .format(DateTime(DateTime.now().year, counter + 1))
            .toString());
    Logger().e(monthAll);
    var data = monthAll.indexOf(monthDropdownValue!) + 1;
    Logger().i(data);
    dateController.displayDate = DateTime(yearDropdownValue, data);
  }

  onMonthSelected(String value) {
    Logger().wtf(value);
    monthDropdownValue = value;
    update();
    var monthAll = List<String>.generate(
        12,
        (counter) => DateFormat.MMMM()
            .format(DateTime(DateTime.now().year, counter + 1))
            .toString());
    Logger().e(monthAll);
    var data = monthAll.indexOf(value) + 1;
    Logger().i(data);
    dateController.displayDate = DateTime(yearDropdownValue, data);
    update();
  }

  onDateSelected(
      DateRangePickerSelectionChangedArgs dateRangePickerSelectionChangedArgs) {
    dateOfBirth = dateRangePickerSelectionChangedArgs.value;
    update();
  }
}
