class CreateComment {
  CreateComment({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.data,
  });
  late final bool status;
  late final String errNum;
  late final String msg;
  late final Data data;

  CreateComment.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.comment,
    required this.sellerName,
  });
  late final String comment;
  late final String sellerName;

  Data.fromJson(Map<String, dynamic> json){
    comment = json['comment'];
    sellerName = json['seller name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['comment'] = comment;
    _data['seller name'] = sellerName;
    return _data;
  }
}