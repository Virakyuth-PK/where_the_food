import 'package:where_the_food/app/models/response/menu/menu_model.dart';

import '../user/user_model.dart';

class OrderModel {
  List<MenuModel>? menu;
  String? sId;
  UserModel? user;
  String? date;
  int? iV;

  OrderModel({this.menu, this.sId, this.user, this.date, this.iV});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['menu'] != null) {
      menu = <MenuModel>[];
      json['menu'].forEach((v) {
        menu!.add(MenuModel.fromJson(v));
      });
    }
    sId = json['_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}