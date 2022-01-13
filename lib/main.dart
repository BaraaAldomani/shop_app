import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/modules/splash_screen.dart';
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
      bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;
      // bool ? isEnglish = CacheHelper.getData(key: 'isEnglis')??false;
      token = CacheHelper.getData(key:'isLogin') ?? '';

      runApp(MyApp(isDark!, token));
      // Use blocs...
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final String token;

  MyApp(this.isDark, this.token, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..changeTheme(isShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.blue[900]),
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
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.grey[700],
              floatingActionButtonTheme:
                  FloatingActionButtonThemeData(backgroundColor: Colors.black),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black45,
              ),
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: SplashScreen(token: token,),
          );
        },
      ),
    );
  }
}

