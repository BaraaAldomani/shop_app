import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppCubit.get(context).isDark? Colors.grey[800] :Colors.blue[200],
      title: Center(
        child: Text(
          AppCubit.get(context).getText('settings')!,
          style: TextStyle(color: AppCubit.get(context).isDark? Colors.white :Colors.blue[900]),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          dividerInfo(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                      color: AppCubit.get(context).isDark
                          ? Colors.blue[900]
                          : Colors.blue.withOpacity(0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        AppCubit.get(context).isDark
                            ? null
                            : AppCubit.get(context).changeTheme();
                        print(AppCubit.get(context).isDark);
                      },
                      child: Text(
                        AppCubit.get(context).getText('dark')!,
                        style: TextStyle(color: Colors.white, fontSize: !AppCubit.get(context).isEnglish? 15 :20),
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
                      color: !AppCubit.get(context).isDark
                          ? Colors.blue[900]:Colors.blue.withOpacity(0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MaterialButton(
                      child: Text(
                        AppCubit.get(context).getText('light')!,
                        style: TextStyle(color: Colors.white, fontSize: !AppCubit.get(context).isEnglish? 15 :20),
                      ),
                      onPressed: () {
                        !AppCubit.get(context).isDark
                            ? null
                            : AppCubit.get(context).changeTheme();
                      },
                    ),
                  ),
                ),
              ],
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
                      color: AppCubit.get(context).isEnglish
                          ? Colors.blue[900]
                          : Colors.blue.withOpacity(0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        AppCubit.get(context).isEnglish
                            ? null
                            : AppCubit.get(context).changeLanguage(
                                AppCubit.get(context).isEnglish);
                      },
                      child: Text(
                        AppCubit.get(context).getText('english')!,
                        style: TextStyle(color: Colors.white, fontSize: !AppCubit.get(context).isEnglish? 15 :20),
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
                      color: !AppCubit.get(context).isEnglish
                          ? Colors.blue[900]
                          : Colors.blue.withOpacity(0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MaterialButton(
                      child: Text(
                        AppCubit.get(context).getText('arabic')!,
                        style: TextStyle(color: Colors.white, fontSize: !AppCubit.get(context).isEnglish? 15 :20),
                      ),
                      onPressed: () {
                        !AppCubit.get(context).isEnglish
                            ? null
                            : AppCubit.get(context).changeLanguage(
                                AppCubit.get(context).isEnglish);
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
  }
}
