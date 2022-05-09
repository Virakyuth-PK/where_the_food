import '../menu/menu_model.dart';

class CategoryDetailModel {
  List<MenuModel>? menu;
  String? sId;
  String? name;
  String? iV;

  CategoryDetailModel({this.menu, this.sId, this.name, this.iV});

  CategoryDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['menu'] != null) {
      menu = <MenuModel>[];
      json['menu'].forEach((v) {
        menu!.add(MenuModel.fromJson(v));
      });
    }
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (menu != null) {
      data['menu'] = menu!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['__v'] = iV;
    return data;
  }
}
