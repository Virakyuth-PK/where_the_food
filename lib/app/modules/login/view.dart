import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_the_food/app/utils/color.dart';
import 'package:where_the_food/app/widgets/button_custom.dart';

import '../../widgets/test_gradient.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.find<LoginLogic>();
  final state = Get.find<LoginLogic>().state;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextGradient(
              'Hello',
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
              'Login first to continue',
              style: GoogleFonts.comfortaa(fontSize: 20, color: mainColor),
            ),
            const SizedBox(
              height: 95,
            ),
            TextField(
              controller: logic.userNameController,
              focusNode: logic.userNameFocusNode,
              style: GoogleFonts.comfortaa(fontSize: 15),
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.only(left: 15),
                hintText: "Username",
                hintStyle:
                    GoogleFonts.comfortaa(fontSize: 15, color: Colors.black54),
                fillColor: Colors.black12,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: halfMainColor)),
              ),
              maxLines: 1,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 30,
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
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0)),
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
                textInputAction: TextInputAction.done,
                onSubmitted: (data)  {
                  logic.onPressedLogin();
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forget password?',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80,),
            ButtonCustom(
              toolTip: 'Login',
              onPress: () {
                logic.onPressedLogin();
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius : const BorderRadius.all( Radius.circular(10),
                    ),
                    color : halfMainColor,
                  ),
                child: Center(
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
