import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_the_food/app/data/api/api_utils.dart';
import 'package:where_the_food/app/modules/cart/binding.dart';
import 'package:where_the_food/app/modules/cart/view.dart';
import 'package:where_the_food/app/modules/product_detail/binding.dart';
import 'package:where_the_food/app/modules/product_detail/view.dart';
import 'package:where_the_food/app/utils/color.dart';
import 'package:where_the_food/app/widgets/button_custom.dart';
import 'package:where_the_food/gen/assets.gen.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.find<HomeLogic>();
  final state = Get
      .find<HomeLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 150,
          leading: ButtonCustom(
            toolTip: 'Account',
            onPress: () {
              logic.onPressedAccount();
            },
            child: Center(
              child: Text(
                'WTF',
                textAlign: TextAlign.left,
                style: GoogleFonts.fredokaOne(
                  color: mainColor,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          actions: [
            ButtonCustom(
              toolTip: 'Cart',
              onPress: () {
                Get.to(() => CartPage(), binding: CartBinding());
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  width: 40,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(7.5),
                  child: Center(
                      child: Image.asset(Assets.images.png.shoppingCart.path))),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: logic.searchController,
                    style: GoogleFonts.comfortaa(fontSize: 15),
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 15),
                      prefixIcon: Container(
                          width: 25,
                          padding: const EdgeInsets.all(15),
                          child: Center(
                              child: Image.asset(
                                  Assets.images.png.magnifier.path))),
                      hintText: "Search",
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
                ),
                const SizedBox(
                  width: 1,
                ),
                ButtonCustom(
                  toolTip: 'Filter',
                  onPress: () {
                    logic.onPressedFilter();
                  },
                  child: Container(
                    width: 30,
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: Image.asset(Assets.images.png.filter.path),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Categories',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.fredokaOne(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'See all',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.comfortaa(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 35,
              child: GetBuilder<HomeLogic>(
                builder: (logic) {
                  return ListView.builder(
                    itemCount: logic.categoriesList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ButtonCustom(
                        toolTip: logic.categoriesList[index].name!,
                        onPress: () {
                          logic.onPressedCategory(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: logic.selectedCategoryIndex == index
                                ? halfMainColor
                                : Colors.transparent,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                            child: Text(
                              logic.categoriesList[index].name!,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: logic.selectedCategoryIndex == index
                                    ? Colors.white
                                    : Colors.black54,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<HomeLogic>(
              builder: (logic) {
                return Expanded(
                  child: PageView.builder(
                    controller: logic.pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: logic
                              .categoryDetailList[logic.selectedCategoryIndex]
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return ButtonCustom(
                              toolTip: 'Item $index',
                              onPress: () {
                                logic.onPressedProduct(logic
                                    .categoryDetailList[logic
                                    .selectedCategoryIndex][index]);
                              },
                              child: Card(
                                margin: const EdgeInsets.all(10),
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.white,
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: testingBaseUrl +
                                          logic
                                              .categoryDetailList[logic
                                              .selectedCategoryIndex][index]
                                              .image!,
                                      imageBuilder: (context, imageProvider) =>
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                10),
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
                                            height: 150,
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
                                    Stack(
                                      children: [
                                        Opacity(
                                          opacity: 0.5,
                                          child: Container(
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(
                                                    10),
                                              ),
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    width: 120,
                                                    child: Text(
                                                      logic
                                                          .categoryDetailList[logic
                                                          .selectedCategoryIndex]
                                                      [index]
                                                          .name!,
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .comfortaa(
                                                        color: Colors.white,
                                                        fontSize: 12.5,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '\$ ' +
                                                        logic
                                                            .categoryDetailList[logic
                                                            .selectedCategoryIndex]
                                                        [index]
                                                            .price
                                                            .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: GoogleFonts
                                                        .comfortaa(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: ButtonCustom(
                                            onPress: () {
                                              logic.onPressedAddToCart();
                                            },
                                            toolTip: 'Add To Cart',
                                            borderRadius: const BorderRadius
                                                .only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(10),
                                            ),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(0),
                                                  bottomLeft: Radius.circular(
                                                      0),
                                                  bottomRight: Radius.circular(
                                                      10),
                                                ),
                                                color: Colors.white,
                                              ),
                                              padding: const EdgeInsets.all(
                                                  7.5),
                                              child: Center(
                                                child: Image.asset(Assets
                                                    .images.png.addToCart.path),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    itemCount: logic.categoriesList.length,
                  ),
                );
              },
            ),
          ]),
        ));
  }
}
