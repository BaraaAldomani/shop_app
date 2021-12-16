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