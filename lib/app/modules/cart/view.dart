import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_the_food/app/data/api/api_utils.dart';
import 'package:where_the_food/app/utils/color.dart';

import '../../widgets/button_custom.dart';
import 'logic.dart';

class CartPage extends StatelessWidget {
  final logic = Get.find<CartLogic>();
  final state = Get.find<CartLogic>().state;

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
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cart',
              textAlign: TextAlign.left,
              style: GoogleFonts.fredokaOne(
                color: halfMainColor,
                fontSize: 35,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GetBuilder<CartLogic>(
              builder: (logic) {
                if (logic.cartList == null) {
                  return SizedBox.shrink();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: logic.cartList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
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
                                  imageUrl: testingBaseUrl +
                                      logic.cartList![index].image,
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
                                  placeholder: (context, url) => SizedBox(
                                    height: 70,
                                    child: Center(
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: mainColor,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      logic.cartList![index].name,
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.comfortaa(
                                        color: halfMainColor,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '\$ ${logic.cartList![index].price}',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.fredokaOne(
                                      color: halfMainColor,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$ ${double.parse(logic.cartList![index].price) * logic.cartList![index].qty}',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.fredokaOne(
                                  color: halfMainColor,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonCustom(
                                    toolTip: 'Remove',
                                    onPress: () {
                                      logic.onPressedMinus(
                                          logic.cartList![index]);
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
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    logic.cartList![index].qty.toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.fredokaOne(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ButtonCustom(
                                    toolTip: 'Add',
                                    onPress: () {
                                      logic.onPressedAdd(
                                          logic.cartList![index]);
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
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Divider(color: mainColor, thickness: 1),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.comfortaa(
                    color: halfMainColor,
                    fontSize: 20,
                  ),
                ),
                GetBuilder<CartLogic>(
                  builder: (logic) {
                    return Text(
                      '\$ ${logic.total.toStringAsFixed(2)}',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.fredokaOne(
                        color: halfMainColor,
                        fontSize: 30,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonCustom(
              toolTip: 'CheckOut',
              onPress: () {
                logic.onPressedCheckOut();
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
                    'CheckOut',
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
    );
  }
}
