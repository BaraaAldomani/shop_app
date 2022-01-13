class SingleProduct {

  late final bool status;
  late final String errNum;
  late final String msg;
  late final Data data;

  SingleProduct.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }
}

class Data {

  late final int id;
  late final String name;
  late final String image;
  late final String expiretionDate;
  late final String category;
  late final int quantity;
  late final dynamic price;
  late final dynamic pricePro;
  late final int discount_1;
  late final int discountPeriod_1;
  late final int discount_2;
  late final int discountPeriod_2;
  late final int discount_3;
  late final int discountPeriod_3;
  late final int views;
  late final int likesCounts;
  late final bool isLike;
  late final Sellers sellers;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
    expiretionDate = json['expiretion_date'];
    category = json['category'];
    quantity = json['quantity'];
    price = json['price'];
    pricePro = json['pricePro'];
    discount_1 = json['discount_1'];
    discountPeriod_1 = json['discount_period_1'];
    discount_2 = json['discount_2'];
    discountPeriod_2 = json['discount_period_2'];
    discount_3 = json['discount_3'];
    discountPeriod_3 = json['discount_period_3'];
    views = json['views'];
    likesCounts = json['likes_counts'];
    isLike = json['is_like'];
    sellers = Sellers.fromJson(json['sellers']);
  }


}

class Sellers {

  late final int id;
  late final String name;
  late final String email;
  late final String phoneNo;

  Sellers.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
  }


}