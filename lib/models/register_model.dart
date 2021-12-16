class RegisterModel {
  late bool status;
  String? message;
  String? errorNumber;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorNumber = json['errNum'];
    message = json['msg'];
  }
}
