import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialStates());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(
        url: 'login',
        data: {"email": email, "password": password}).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.token);
      emit(ShopLoginSuccessStates(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopLoginChangeVisibilityPasswordStates());
  }
}
