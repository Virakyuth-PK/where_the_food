import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../gen/assets.gen.dart';
import '../../data/api/api_utils.dart';
import '../../utils/color.dart';
import '../../widgets/button_custom.dart';
import 'logic.dart';

class FilterCategoryPage extends StatelessWidget {
  final logic = Get.find<FilterCategoryLogic>();
  final state = Get.find<FilterCategoryLogic>().state;

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
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter',
                textAlign: TextAlign.left,
                style: GoogleFonts.fredokaOne(
                  color: halfMainColor,
                  fontSize: 35,
                ),
              ),
              Expanded(
                child: GetBuilder<FilterCategoryLogic>(
                  builder: (logic) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: logic.listFilter.length,
                      itemBuilder: (context, indexCategory) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              logic.categoriesList[indexCategory].name!,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.fredokaOne(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: logic
                                    .categoryDetailListFilter[indexCategory]
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.all(10.0),
                                    child: Stack(
                                      children: [
                                        ButtonCustom(
                                          toolTip: logic
                                              .categoryDetailListFilter[
                                                  indexCategory][index]
                                              .name!,
                                          onPress: () {
                                            logic.homeLogic.onPressedProduct(
                                                logic.categoryDetailListFilter[
                                                    indexCategory][index]);
                                          },
                                          child: Card(
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: Colors.white,
                                            child: Stack(
                                              alignment: AlignmentDirectional
                                                  .bottomCenter,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: testingBaseUrl +
                                                      logic
                                                          .categoryDetailListFilter[
                                                              indexCategory]
                                                              [index]
                                                          .image!,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: mainColor,
                                                          strokeWidth: 3,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                                Stack(
                                                  children: [
                                                    Opacity(
                                                      opacity: 0.5,
                                                      child: Container(
                                                        height: 60,
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned.fill(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          SizedBox(
                                                            width: 120,
                                                            child: Text(
                                                              logic
                                                                  .categoryDetailListFilter[
                                                                      indexCategory]
                                                                      [index]
                                                                  .name!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts
                                                                  .comfortaa(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12.5,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            '\$ ' +
                                                                logic
                                                                    .categoryDetailListFilter[
                                                                        indexCategory]
                                                                        [index]
                                                                    .price
                                                                    .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: GoogleFonts
                                                                .comfortaa(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 4,
                                          right: 4,
                                          child: ButtonCustom(
                                            onPress: () {
                                              logic.homeLogic.onPressedAddToCart(
                                                  logic.categoryDetailListFilter[
                                                      indexCategory][index]);
                                            },
                                            toolTip: 'Add To Cart',
                                            borderRadius:
                                                const BorderRadius.only(
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
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                color: Colors.white,
                                              ),
                                              padding:
                                                  const EdgeInsets.all(7.5),
                                              child: Center(
                                                child: Image.asset(Assets
                                                    .images.png.addToCart.path),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
