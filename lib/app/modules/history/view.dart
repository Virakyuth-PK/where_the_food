import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:where_the_food/app/widgets/button_custom.dart';

import '../../data/api/api_utils.dart';
import '../../utils/color.dart';
import 'logic.dart';

class HistoryPage extends StatelessWidget {
  final logic = Get.find<HistoryLogic>();
  final state = Get.find<HistoryLogic>().state;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.fredokaOne(
                    color: halfMainColor,
                    fontSize: 35,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<HistoryLogic>(
                builder: (logic) {
                  return ListView.builder(
                    itemCount: logic.listOrderHistoryModel.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (logic.listOrderHistoryModel[index].menu!.isEmpty) {
                        return SizedBox.shrink();
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat("yyyy-MM-dd hh:mm a").format(DateTime.parse(
                                  logic.listOrderHistoryModel[index].date!)),
                              style: GoogleFonts.comfortaa(fontSize: 15),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              // height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // scrollDirection: Axis.horizontal,
                                itemCount: logic
                                    .listOrderHistoryModel[index].menu!.length,
                                itemBuilder: (context, indexMenu) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: ButtonCustom(
                                      onPress: () {},
                                      toolTip: logic
                                          .listOrderHistoryModel[index]
                                          .menu![indexMenu]
                                          .name!,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: shadowColor,
                                                          offset: const Offset(
                                                              0, 4),
                                                          blurRadius: 4)
                                                    ],
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: testingBaseUrl +
                                                        logic
                                                            .listOrderHistoryModel[
                                                                index]
                                                            .menu![indexMenu]
                                                            .image!,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            SizedBox(
                                                      height: 70,
                                                      child: Center(
                                                        child: SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: mainColor,
                                                            strokeWidth: 2,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 200,
                                                      child: Text(
                                                        logic
                                                            .listOrderHistoryModel[
                                                                index]
                                                            .menu![indexMenu]
                                                            .name!,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .comfortaa(
                                                          color: halfMainColor,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '\$ ${logic.listOrderHistoryModel[index].menu![indexMenu].price}',
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .fredokaOne(
                                                        color: halfMainColor,
                                                        fontSize: 15,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
