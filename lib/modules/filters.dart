import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class Filters extends StatefulWidget {
  Filters({Key? key}) : super(key: key);

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var filterCategoryController = TextEditingController(text: 'Category');
  var filterExpController = TextEditingController(text: 'Expiration date');

  int valueRadio = 0;
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
                'Filters',
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dividerInfo(),
                ListTile(
                  title: Text(filterCategoryController.text),
                  leading: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => Container(
                                color: Colors.blue[900]?.withOpacity(0.1),
                                child: Dialog(
                                  child: SizedBox(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        RadioListTile(
                                          activeColor: Colors.blue[900],
                                          title: Text('Canned'),
                                          value: 1,
                                          groupValue: valueRadio,
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              valueRadio = value.hashCode;
                                              filterCategoryController.text =
                                                  'Canned';
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                            activeColor: Colors.blue[900],
                                            title: Text('Vegetable'),
                                            value: 2,
                                            groupValue: valueRadio,
                                            onChanged: (dynamic value) {
                                              setState(() {
                                                filterCategoryController.text =
                                                    'vegetable';
                                                valueRadio = value.hashCode;
                                                Navigator.of(context).pop();
                                              });
                                            }),
                                        RadioListTile(
                                          activeColor: Colors.blue[900],
                                          title: Text('Fruit'),
                                          value: 3,
                                          groupValue: valueRadio,
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              valueRadio = value.hashCode;
                                              filterCategoryController.text =
                                                  'Fruit';
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                ListTile(
                  title: Text(filterExpController.text),
                  leading: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => Container(
                                color: Colors.blue[900]?.withOpacity(0.1),
                                child: Dialog(
                                  child: SizedBox(
                                    height: 200,
                                    child: Column(
                                      children: [
                                        RadioListTile(
                                          activeColor: Colors.blue[900],
                                          title: Text('a -> A'),
                                          value: 1,
                                          groupValue: valueRadio,
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              valueRadio = value.hashCode;
                                              filterExpController.text =
                                                  'a -> A';
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                        RadioListTile(
                                            activeColor: Colors.blue[900],
                                            title: Text('A -> a'),
                                            value: 2,
                                            groupValue: valueRadio,
                                            onChanged: (dynamic value) {
                                              setState(() {
                                                filterExpController.text =
                                                    'A -> a';
                                                valueRadio = value.hashCode;
                                                Navigator.of(context).pop();
                                              });
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    },
                    icon: Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(5)),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
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
