import 'package:get/get.dart';
import 'package:where_the_food/app/data/api/api.dart';
import 'package:where_the_food/app/models/response/order/order_model.dart';

import '../../models/response/order_history/order_history.dart';
import 'state.dart';

class HistoryLogic extends GetxController {
  final HistoryState state = HistoryState();
  List<OrderHistoryModel> listOrderHistoryModel = <OrderHistoryModel>[];

  @override
  Future<void> onInit() async {
    super.onInit();
    await getOrders();
  }

  getOrders() async {
    await Api().getAllOrder(
      onSuccess: (data) {
        data.sort((a,b)=> DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
        listOrderHistoryModel.addAll(data);
        update();
      },
    );
  }
}
