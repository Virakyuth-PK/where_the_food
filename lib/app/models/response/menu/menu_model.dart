
class Menu {
  String? sId;
  String? name;
  String? image;
  String? description;
  double? price;
  String? category;
  int? iV;

  Menu(
      {this.sId,
        this.name,
        this.image,
        this.description,
        this.price,
        this.category,
        this.iV});

  Menu.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    price = json['price'];
    category = json['category'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['__v'] = iV;
    return data;
  }
}
