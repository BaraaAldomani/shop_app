import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return AlertDialog(
            backgroundColor: Colors.blue[200],
            title: Center(
              child: Text(
                'Settings',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dividerInfo(),
                SwitchListTile(
                  activeColor: Colors.blue[900],
                  onChanged: (value) {
                    cubit.changeTheme();
                  },
                  value: cubit.isDark,
                  title: Text(
                    'Dark Mode',
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                            color: cubit.isEnglish
                                ? Colors.blue[900]
                                : Colors.blue[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              cubit.isEnglish
                                  ? null
                                  : cubit.changeLanguage(cubit.isEnglish);
                            },
                            child: Text(
                              'Arabic',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                            color: !cubit.isEnglish
                                ? Colors.blue[900]
                                : Colors.blue[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: MaterialButton(
                            child: Text(
                              'English',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              !cubit.isEnglish
                                  ? null
                                  : cubit.changeLanguage(cubit.isEnglish);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
