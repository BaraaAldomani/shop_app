import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginSuccessStates extends ShopLoginStates {
  final LoginModel loginModel;

  ShopLoginSuccessStates(this.loginModel);
}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginChangeVisibilityPasswordStates extends ShopLoginStates {}

class ShopLoginErrorStates extends ShopLoginStates {
  final String error;

  ShopLoginErrorStates(this.error);
}
