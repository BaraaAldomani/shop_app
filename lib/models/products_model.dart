class ProductsModel {
  ProductsModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String errNum;
  late final String msg;
  late final List<Data> data;

  ProductsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
  required this.name,
  required this.image,
  required this.id,
  required this.views,
  required this.likes,
  required this.expiretionDate,
  required this.is_like,
});
late final String name;
late final String image;
late final int id;
late final int views;
late final int likes;
late final String expiretionDate;
late final bool is_like;

Data.fromJson(Map<String, dynamic> json){
name = json['name'];
image = json['image'];
id = json['id'];
views = json['views'];
likes = json['likes'];
expiretionDate = json['expiretion_date'];
is_like = json['is like'];
}

Map<String, dynamic> toJson() {
  final _data = <String, dynamic>{};
  _data['name'] = name;
  _data['image'] = image;
  _data['id'] = id;
  _data['views'] = views;
  _data['likes'] = likes;
  _data['expiretion_date'] = expiretionDate;
  _data['is like'] = is_like;
  return _data;
}
}