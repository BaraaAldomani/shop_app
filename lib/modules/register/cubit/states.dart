import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/register_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialStates extends ShopRegisterStates {}
class ShopRegisterLoadingStates extends ShopRegisterStates {}
class ShopRegisterSuccessStates extends ShopRegisterStates {
  final RegisterModel registerModel;
  ShopRegisterSuccessStates(this.registerModel);
}
class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorStates(this.error);
}
class  RegisterLoginSuccessStates extends ShopRegisterStates{
  final LoginModel loginModel;

  RegisterLoginSuccessStates(this.loginModel);
}
class  RegisterLoginLoadingStates extends ShopRegisterStates{}
class  RegisterLoginErrorStates extends ShopRegisterStates{}
