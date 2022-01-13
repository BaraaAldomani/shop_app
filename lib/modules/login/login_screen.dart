import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formLoginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                  key: 'isLogin', value: state.loginModel.token).then((value) {
                    token = state.loginModel.token!;
              }).then((value){
                Fluttertoast.showToast(
                    msg: state.loginModel.message.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green)
                    .then((value) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ShopLayout()));
                });
              });

            } else if (!state.loginModel.status) {
              print(state.loginModel.message.toString());
              Fluttertoast.showToast(
                  msg: state.loginModel.message.toString(),
                  backgroundColor: Colors.red[900]);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formLoginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            color:AppCubit.get(context).isDark? Colors.white:  Colors.blue[900],
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      defaultTextField(
                          context: context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefixIcon: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email must be not empty';
                            } else if (!value.contains('@')) {
                              return 'you are forget (@) ';
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                        context: context,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        label: 'password',
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffixIcon: IconButton(
                          icon: Icon(ShopLoginCubit.get(context).suffix),
                          onPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        prefixIcon: Icons.lock,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password must be not empty';
                          } else if (value.length < 8) {
                            return 'password must be more than 8';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:AppCubit.get(context).isDark?Colors.black:  Colors.blue[900],
                        ),
                        child: MaterialButton(
                          child: state is! ShopLoginLoadingStates
                              ? Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : CircularProgressIndicator(),
                          onPressed: () {
                            if (formLoginKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);


                            }
                          },
                          height: 60,
                          minWidth: double.infinity,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'did not have an account?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(color:AppCubit.get(context).isDark?Colors.white:  Colors.blue[900]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
