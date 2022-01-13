class SearchModel {
  final bool? status;
  final String? errNum;
  final String? msg;
  final List<Data>? data;

  SearchModel({
    this.status,
    this.errNum,
    this.msg,
    this.data,
  });

  SearchModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        errNum = json['errNum'] as String?,
        msg = json['msg'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'errNum' : errNum,
    'msg' : msg,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final String? name;
  final String? image;
  final int? views;
  final int? likesCounts;
  final String? expiretionDate;
  final dynamic price;
  final dynamic pricePro;
  final bool? isLike;

  Data({
    this.id,
    this.name,
    this.image,
    this.views,
    this.likesCounts,
    this.expiretionDate,
    this.price,
    this.pricePro,
    this.isLike,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        image = json['image'] as String?,
        views = json['views'] as int?,
        likesCounts = json['likes_counts'] as int?,
        expiretionDate = json['expiretion_date'] as String?,
        price = json['price'] as dynamic,
        pricePro = json['pricePro'] as dynamic,
        isLike = json['is_like'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'image' : image,
    'views' : views,
    'likes_counts' : likesCounts,
    'expiretion_date' : expiretionDate,
    'price' : price,
    'pricePro' : pricePro,
    'is_like' : isLike
  };
}