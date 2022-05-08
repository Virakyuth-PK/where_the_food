import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_the_food/app/data/api/api_utils.dart';
import 'package:where_the_food/app/modules/cart/binding.dart';
import 'package:where_the_food/app/modules/cart/view.dart';
import 'package:where_the_food/app/utils/color.dart';
import 'package:where_the_food/app/widgets/button_custom.dart';
import 'package:where_the_food/gen/assets.gen.dart';

import 'logic.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with WidgetsBindingObserver {
  final logic = Get.find<ProductDetailLogic>();

  final state = Get
      .find<ProductDetailLogic>()
      .state;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      await logic.checkProductAdded();
    }
  }

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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 25, right: 25, bottom: 100, top: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        logic.selectedProduct.name!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                          color: Colors.black87,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.fredokaOne(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '\$ ',
                          style: GoogleFonts.fredokaOne(color: halfMainColor)),
                      TextSpan(
                        text: logic.selectedProduct.price,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 240,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: shadowColor,
                          offset: const Offset(0, 4),
                          blurRadius: 4)
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: testingBaseUrl + logic.selectedProduct.image!,
                    imageBuilder: (context, imageProvider) =>
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    placeholder: (context, url) =>
                        SizedBox(
                          height: 200,
                          child: Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: mainColor,
                                strokeWidth: 3,
                              ),
                            ),
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonCustom(
                      toolTip: 'Remove',
                      onPress: () {
                        if (logic.qty.value > 0) {
                          logic.qty.value--;
                        }
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: halfMainColor,
                        ),
                        child: Center(
                          child: Text(
                            "-",
                            style: GoogleFonts.fredokaOne(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Obx(() {
                      return Text(
                        logic.qty.value.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fredokaOne(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      );
                    }),
                    const SizedBox(
                      width: 30,
                    ),
                    ButtonCustom(
                      toolTip: 'Add',
                      onPress: () {
                        logic.qty.value++;
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: halfMainColor,
                        ),
                        child: Center(
                          child: Text(
                            "+",
                            style: GoogleFonts.fredokaOne(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(() {
                  return Text(
                    '\$ ${(double.parse(logic.selectedProduct.price!) *
                        logic.qty.value)}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      color: Colors.black45,
                      fontSize: 15,
                    ),
                  );
                }),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'About Product',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.fredokaOne(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam augue nibh, fermentum quis justo quis, interdum gravida tellus. Phasellus euismod mattis eros nec varius. Praesent suscipit augue sit amet massa rutrum lacinia. Donec facilisis iaculis ex non bibendum. Aliquam volutpat varius lectus. Nam non pharetra enim, eget bibendum risus. Proin.",
                  textAlign: TextAlign.center,
                  style:
                  GoogleFonts.comfortaa(fontSize: 15, color: Colors.black),
                ),
              ],
            ),
          ),
          GetBuilder<ProductDetailLogic>(
            builder: (logic) {
              return Positioned(
                bottom: 25,
                left: 25,
                right: 25,
                child: Row(
                  children: [
                    logic.productAlreadyAdded == true
                        ? ButtonCustom(
                      toolTip: 'Add To Cart',
                      onPress: () {
                        logic.onPressedAddToCart();
                      },
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child:
                          Image.asset(Assets.images.png.addToCart.path),
                        ),
                      ),
                    )
                        : SizedBox.shrink(),
                    logic.productAlreadyAdded == true
                        ? const SizedBox(
                      width: 10,
                    )
                        : SizedBox.shrink(),
                    Flexible(
                      flex: 1,
                      child: ButtonCustom(
                        toolTip: logic.productAlreadyAdded == false
                            ? 'Add To Cart'
                            : 'Go To Cart',
                        onPress: () {
                          if (logic.productAlreadyAdded == false) {
                            logic.onPressedAddToCart();
                          } else {
                            Get.to(() => CartPage(), binding: CartBinding());
                          }
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
                              logic.productAlreadyAdded == false
                                  ? 'Add To Cart'
                                  : 'Go To Cart',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.comfortaa(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
