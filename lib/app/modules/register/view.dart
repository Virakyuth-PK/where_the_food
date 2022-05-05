import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/color.dart';
import '../../widgets/button_custom.dart';
import '../../widgets/test_gradient.dart';
import 'logic.dart';

class RegisterPage extends StatelessWidget {
  final logic = Get.find<RegisterLogic>();
  final state = Get.find<RegisterLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.grey),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextGradient(
                'Register',
                style: GoogleFonts.fredokaOne(fontSize: 30),
                gradient: LinearGradient(colors: [
                  mainColor,
                  halfMainColor,
                ]),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Get your free account first',
                style: GoogleFonts.comfortaa(fontSize: 20, color: mainColor),
              ),
              const SizedBox(
                height: 130,
              ),
              TextField(
                controller: logic.userNameController,
                focusNode: logic.userNameFocusNode,
                style: GoogleFonts.comfortaa(fontSize: 15),
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: "Username",
                  hintStyle: GoogleFonts.comfortaa(
                      fontSize: 15, color: Colors.black54),
                  fillColor: Colors.black12,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: halfMainColor)),
                ),
                maxLines: 1,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: logic.fullNameController,
                focusNode: logic.fullNameFocusNode,
                style: GoogleFonts.comfortaa(fontSize: 15),
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: "Full Name",
                  hintStyle: GoogleFonts.comfortaa(
                      fontSize: 15, color: Colors.black54),
                  fillColor: Colors.black12,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: halfMainColor)),
                ),
                maxLines: 1,
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  logic.onPressedDateOfBirth();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              GetBuilder<RegisterLogic>(
                builder: (controller) {
                  var dateText = 'Date Of Birth';
                  if (logic.dateButtonClicked.isTrue) {
                    dateText =
                        DateFormat("dd MMMM yyyy").format(logic.dateOfBirthConfirmed);
                  }
                  return ButtonCustom(
                    toolTip: 'Date Of Birth',
                    onPress: () {
                      logic.onPressedDateOfBirth();
                    },
                    child: Container(
                      width: Get.width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateText,
                            style: GoogleFonts.comfortaa(
                                fontSize: 15, color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 25,
              ),
              Divider(color: mainColor, thickness: 1),
              SizedBox(
                height: 25,
              ),
              Obx(
                () => TextField(
                  controller: logic.passwordController,
                  focusNode: logic.passwordFocusNode,
                  style: GoogleFonts.comfortaa(fontSize: 15),
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.only(left: 15),
                    hintText: "Password",
                    hintStyle: GoogleFonts.comfortaa(
                        fontSize: 15, color: Colors.black54),
                    fillColor: Colors.black12,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: halfMainColor)),
                    suffixIcon: InkWell(
                      onTap: () => logic.isPasswordObscureText.toggle(),
                      child: Icon(
                        logic.isPasswordObscureText.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: logic.isPasswordObscureText.value,
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) {
                    logic.passwordFocusNode.nextFocus();
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: logic.confirmPasswordController,
                focusNode: logic.confirmPasswordFocusNode,
                style: GoogleFonts.comfortaa(fontSize: 15),
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 15),
                  hintText: "Confirm Password",
                  hintStyle: GoogleFonts.comfortaa(
                      fontSize: 15, color: Colors.black54),
                  fillColor: Colors.black12,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: halfMainColor)),
                ),
                maxLines: 1,
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 80,
              ),
              ButtonCustom(
                toolTip: 'Register',
                onPress: () {
                  logic.onPressedRegister();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: halfMainColor,
                  ),
                  child: Center(
                    child: Text(
                      'Register',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
