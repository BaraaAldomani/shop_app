class ProfileModel {
  final bool? status;
  final String? errNum;
  final String? msg;
  final SellerDetails? sellerDetails;
  final List<Data>? data;

  ProfileModel({
    this.status,
    this.errNum,
    this.msg,
    this.sellerDetails,
    this.data,
  });

  ProfileModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as bool?,
        errNum = json['errNum'] as String?,
        msg = json['msg'] as String?,
        sellerDetails = (json['sellerDetails'] as Map<String,dynamic>?) != null ? SellerDetails.fromJson(json['sellerDetails'] as Map<String,dynamic>) : null,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'status' : status,
    'errNum' : errNum,
    'msg' : msg,
    'sellerDetails' : sellerDetails?.toJson(),
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class SellerDetails {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNo;

  SellerDetails({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
  });

  SellerDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        phoneNo = json['phone_no'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'phone_no' : phoneNo
  };
}

class Data {
  final int? id;
  final String? name;
  final String? image;
  final String? expiretionDate;
  final dynamic price;
  final int? views;
  final int? likesCounts;
  final dynamic pricePro;
  final bool? isLike;

  Data({
    this.id,
    this.name,
    this.image,
    this.expiretionDate,
    this.price,
    this.views,
    this.likesCounts,
    this.pricePro,
    this.isLike,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        image = json['image'] as String?,
        expiretionDate = json['expiretion_date'] as String?,
        price = json['price'] as dynamic,
        views = json['views'] as int?,
        likesCounts = json['likes_counts'] as int?,
        pricePro = json['pricePro'] as dynamic,
        isLike = json['is_like'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'image' : image,
    'expiretion_date' : expiretionDate,
    'price' : price,
    'views' : views,
    'likes_counts' : likesCounts,
    'pricePro' : pricePro,
    'is_like' : isLike
  };
}