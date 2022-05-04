import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_the_food/app/modules/login/binding.dart';
import 'package:where_the_food/app/modules/login/view.dart';
import 'package:where_the_food/app/modules/register/binding.dart';
import 'package:where_the_food/app/modules/register/view.dart';
import 'package:where_the_food/app/widgets/button_custom.dart';
import 'package:where_the_food/gen/assets.gen.dart';

import '../../utils/color.dart';
import 'logic.dart';

class WelcomePage extends StatelessWidget {
  final logic = Get.find<WelcomeLogic>();
  final state = Get.find<WelcomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [halfMainColor, mainColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromRGBO(0, 0, 0, 0.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4)
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(Assets.images.png.soramitsuLogo.path),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Welcome to WTF',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.fredokaOne(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: Get.width * 0.75,
                    child: Text(
                      'Where The Food easy way to get grocery in town.',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonCustom(
                      onPress: () {
                        Get.to(() => LoginPage(), binding: LoginBinding());
                      },
                      toolTip: "Login",
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: shadowColor,
                                offset: const Offset(0, 4),
                                blurRadius: 4)
                          ],
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                              color: halfMainColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ButtonCustom(
                      toolTip: 'Register',
                      onPress: () {
                        Get.to(() => RegisterPage(),
                            binding: RegisterBinding());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
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
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Terms of service',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
