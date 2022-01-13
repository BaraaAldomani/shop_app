
class LoginModel{
 late bool status;
  String? errorNumber;
  String? message;
  String? token;

  LoginModel.fromJson(Map <String ,dynamic> json){
    status = json['status'];
    errorNumber = json['errNum'];
    message = json['msg'];
    token = json['token'];
  }
}