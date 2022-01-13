class ListComments {
  ListComments({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String errNum;
  late final String msg;
  late final List<Data> data;

  ListComments.fromJson(Map<String, dynamic> json){
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
    required this.sellerId,
    required this.comment,
  });
  late final int sellerId;
  late final String comment;

  Data.fromJson(Map<String, dynamic> json){
    sellerId = json['seller_id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['seller_id'] = sellerId;
    _data['comment'] = comment;
    return _data;
  }
}