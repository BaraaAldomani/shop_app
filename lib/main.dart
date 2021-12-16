import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import 'modules/login/login_screen.dart';
import 'shared/components/constants.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      DioHelper.init();
      await CacheHelper.init();
      runApp(MyApp());
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: cubit.isDark ? darkTheme() : lightThemeData(),
            home: ShopLayout(),
          );
        },
      ),
    );
  }
}

ThemeData lightThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.blue[900]),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue[900],
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade900)),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[800],
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.black),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black45,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade900)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade900)),
    ),
  );
}
