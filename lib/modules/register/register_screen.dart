import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

var emailController = TextEditingController();
var nameController = TextEditingController();
var passwordController = TextEditingController();
var passwordConfirmController = TextEditingController();
var phoneController = TextEditingController();
var phoneCountryController = TextEditingController();

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formRegisterKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessStates) {
            if (state.registerModel.status) {
              Fluttertoast.showToast(
                      msg: state.registerModel.message.toString(),
                      backgroundColor: Colors.green,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1)
                  .then((value) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            } else {
              Fluttertoast.showToast(
                msg: state.registerModel.message.toString(),
                backgroundColor: Colors.red,
                gravity: ToastGravity.BOTTOM,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formRegisterKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Register',
                        style: TextStyle(
                            color: AppCubit.get(context).isDark
                                ? Colors.white
                                : Colors.blue[900],
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      defaultTextField(
                          context: context,
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Name',
                          prefixIcon: Icons.email,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Name must be not empty';
                            } else if (value.length < 4) {
                              return 'Name must be more than 3 char';
                            }
                          }),
                      SizedBox(
                        height: 20,
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
                              return 'must be an email';
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
                          prefixIcon: Icons.lock,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password must be not empty';
                            } else if (value.length < 8) {
                              passwordController.clear();
                              return 'password must be more than 7';
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextField(
                          context: context,
                          controller: passwordConfirmController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Confirm password',
                          prefixIcon: Icons.lock,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password must be not empty';
                            } else if (value.toString() !=
                                passwordController.text) {
                              passwordConfirmController.clear();
                              return 'Passwords dont the same';
                            }
                          }),
                      SizedBox(height: 20),
                      defaultTextField(
                          context: context,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          label: 'Phone Number',
                          suffixIcon: CountryCodePicker(
                            favorite: ['sa', 'eg', 'sy'],
                            barrierColor: Colors.blue[900]?.withOpacity(0.4),
                            onInit: (value) =>
                                phoneCountryController.text = value.toString(),
                            onChanged: (value) =>
                                phoneCountryController.text = value.toString(),
                            initialSelection: 'sy',
                            dialogSize: Size(300, 500),
                          ),
                          prefixIcon: Icons.phone,
                          validate: (value) {
                            if (value!.length < 9) {
                              return 'Phone Number be more than 8';
                            }
                            return null;
                          }),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppCubit.get(context).isDark
                              ? Colors.black
                              : Colors.blue[900],
                        ),
                        child: MaterialButton(
                          child: GestureDetector(
                            child: state is! ShopRegisterLoadingStates
                                ? Text(
                                    'Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  )
                                : CircularProgressIndicator(),
                          ),
                          onPressed: () {
                            if (formRegisterKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  passwordConfirm:
                                      passwordConfirmController.text,
                                  phoneNumber: phoneController.text);
                            }
                          },
                          height: 60,
                          minWidth: double.infinity,
                        ),
                      ),
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
