class DeleteProductModel {

  late final bool status;
  late final dynamic errNum;
  late final String msg;

  DeleteProductModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }
}