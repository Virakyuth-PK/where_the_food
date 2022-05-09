import 'package:where_the_food/app/models/response/menu/menu_model.dart';

class OrderHistoryModel {
  List<MenuModel>? menu;
  String? sId;
  String? user;
  String? date;
  int? iV;

  OrderHistoryModel({this.menu, this.sId, this.user, this.date, this.iV});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['menu'] != null) {
      menu = <MenuModel>[];
      json['menu'].forEach((v) {
        menu!.add(MenuModel.fromJson(v));
      });
    }
    sId = json['_id'];
    user = json['user'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (menu != null) {
      data['menu'] = menu!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['user'] = user;
    data['date'] = date;
    data['__v'] = iV;
    return data;
  }
}
