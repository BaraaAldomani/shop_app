import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialStates());

 static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late RegisterModel registerModel;

  void userRegister(
      {required String name,
      required String email,
      required String password,
      required String passwordConfirm,
      required String phoneNumber}) {
    emit(ShopRegisterLoadingStates());
    DioHelper.postData(url: 'register', data: {
      'name': name,
      "email": email,
      "password": password,
      'password_confirmation': passwordConfirm,
      'phone_no': phoneNumber,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      emit(ShopRegisterSuccessStates(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorStates(error.toString()));
    });
  }

  late LoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(RegisterLoginLoadingStates());
    DioHelper.postData(
        url: 'login',
        data: {"email": email, "password": password}).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.token);
      emit(RegisterLoginSuccessStates(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterLoginErrorStates());
    });
  }
}
