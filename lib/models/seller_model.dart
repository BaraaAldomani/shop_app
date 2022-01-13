class SellerModel {
  SellerModel({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.sellerDetails,
  });
  late final bool status;
  late final String errNum;
  late final String msg;
  late final SellerDetails sellerDetails;

  SellerModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    sellerDetails = SellerDetails.fromJson(json['sellerDetails']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['sellerDetails'] = sellerDetails.toJson();
    return _data;
  }
}

class SellerDetails {
  SellerDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String phoneNo;

  SellerDetails.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone_no'] = phoneNo;
    return _data;
  }
}