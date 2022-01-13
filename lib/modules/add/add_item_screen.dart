import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/add/cubit/cubit.dart';
import 'package:shop_app/modules/add/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class AddItem extends StatefulWidget {
  AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  var nameController = TextEditingController();
  var categoryController = TextEditingController();
  var quantityController = TextEditingController();
  var priceController = TextEditingController();
  var expController = TextEditingController();
  var dis1Controller = TextEditingController();
  var dis2Controller = TextEditingController();
  var dis3Controller = TextEditingController();
  var exp1Controller = TextEditingController();
  var exp2Controller = TextEditingController();
  var exp3Controller = TextEditingController();
  var exp4Controller = TextEditingController();
  var exp5Controller = TextEditingController();
  late String dateFormat;
  final ImagePicker _imagePicker = ImagePicker();
  var formAddKey = GlobalKey<FormState>();
  int day = 0;
  bool isUpload = false;

  Future<File> urlToFile() async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http
        .get(Uri.parse('https://semantic-ui.com/images/wireframe/image.png'));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  File? _image;

  bool photoIsTake = false;

  Future getImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
      photoIsTake = true;
    });
  }

  int valueRadio = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddItemCubit(),
      child: BlocConsumer<AddItemCubit, AddItemStates>(
        listener: (context, state) {
          if (state is AddItemSuccessStates) {
            Fluttertoast.showToast(
                msg: 'uploaded successfully', backgroundColor: Colors.green);
          }
        },
        builder: (context, state) {

          return Directionality(
            textDirection: AppCubit.get(context).isEnglish
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              body: Form(
                key: formAddKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          AppCubit.get(context).getText('add_item')!,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.blue[900]),
                        ),
                      ),
                    ),
                    dividerInfo(context),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(180),
                                        gradient: LinearGradient(
                                            end: Alignment.bottomRight,
                                            begin: Alignment.topRight,
                                            colors: [
                                              AppCubit.get(context).isDark
                                                  ? Colors.white
                                                  : Colors.blue,
                                              AppCubit.get(context).isDark
                                                  ? Colors.grey[900]!
                                                  : Colors.blue[900]!,
                                            ]),
                                      ),
                                    ),
                                    maxRadius: 160),
                                CircleAvatar(
                                  backgroundImage: !photoIsTake
                                      ? AssetImage('assets/image.png')
                                      : Image(image: FileImage(_image!)).image,
                                  maxRadius: 150,
                                  backgroundColor: Colors.blueGrey[200],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                AppCubit.get(context).getText('photo')! + ':',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              Spacer(),
                              SizedBox(
                                  width: 250,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppCubit.get(context).isDark
                                          ? Colors.black
                                          : Colors.blue[900],
                                    ),
                                    child: MaterialButton(
                                      child: Text(
                                          AppCubit.get(context)
                                              .getText('pick_image')!,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Container(
                                                  color: AppCubit.get(context)
                                                          .isDark
                                                      ? Colors.black45
                                                      : Colors.blue[900]
                                                          ?.withOpacity(0.3),
                                                  width: double.infinity,
                                                  height: 180,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 60,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Colors
                                                                  .blue[900]),
                                                          child: MaterialButton(
                                                            color: AppCubit.get(
                                                                        context)
                                                                    .isDark
                                                                ? Colors.black
                                                                : Colors
                                                                    .blue[900],
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              getImage(
                                                                  ImageSource
                                                                      .camera);
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .photo_camera_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                 AppCubit.get(context).getText('camera')!,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 60,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: Colors
                                                                  .blue[900]),
                                                          child: MaterialButton(
                                                            color: AppCubit.get(
                                                                        context)
                                                                    .isDark
                                                                ? Colors.black
                                                                : Colors
                                                                    .blue[900],
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              getImage(
                                                                  ImageSource
                                                                      .gallery);
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .photo_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  AppCubit.get(context).getText('gallery')!,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      minWidth: double.infinity,
                                      height: 60,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                AppCubit.get(context).getText('name')! + ':',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 250,
                                child: defaultTextField(
                                    context: context,
                                    border: 30,
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    label:
                                        AppCubit.get(context).getText('name')!,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Name must be not empty';
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icons.person),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //category
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                AppCubit.get(context).getText('category')! +
                                    ':',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 250,
                                child: defaultTextField(
                                  context: context,
                                  border: 30,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Category must be not empty';
                                    }
                                    return null;
                                  },
                                  controller: categoryController,
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                  label: AppCubit.get(context)
                                      .getText('category')!,
                                  prefixIcon: Icons.category,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                                child: SizedBox(
                                                  height: 200,
                                                  child: Container(
                                                    color: AppCubit.get(context)
                                                            .isDark
                                                        ? Colors.black87
                                                        : Colors.white,
                                                    child: Column(
                                                      children: [
                                                        RadioListTile(
                                                          activeColor:
                                                              AppCubit.get(
                                                                          context)
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors.blue[
                                                                      900],
                                                          title: Text(
                                                            AppCubit.get(
                                                                    context)
                                                                .getText(
                                                                    'canned')!,
                                                            style: TextStyle(
                                                                color: AppCubit.get(
                                                                            context)
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors.blue[
                                                                        900]),
                                                          ),
                                                          value: 1,
                                                          groupValue:
                                                              valueRadio,
                                                          onChanged:
                                                              (dynamic value) {
                                                            setState(() {
                                                              valueRadio = value
                                                                  .hashCode;
                                                              categoryController
                                                                      .text =
                                                                  'canned';
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                        ),
                                                        RadioListTile(
                                                            activeColor: AppCubit
                                                                        .get(
                                                                            context)
                                                                    .isDark
                                                                ? Colors.white
                                                                : Colors
                                                                    .blue[900],
                                                            title: Text(
                                                              AppCubit.get(
                                                                      context)
                                                                  .getText(
                                                                      'vegetable')!,
                                                              style: TextStyle(
                                                                  color: AppCubit.get(
                                                                              context)
                                                                          .isDark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors.blue[
                                                                          900]),
                                                            ),
                                                            value: 2,
                                                            groupValue:
                                                                valueRadio,
                                                            onChanged: (dynamic
                                                                value) {
                                                              setState(() {
                                                                categoryController
                                                                        .text =
                                                                    'vegetable';
                                                                valueRadio = value
                                                                    .hashCode;
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              });
                                                            }),
                                                        RadioListTile(
                                                          activeColor:
                                                              AppCubit.get(
                                                                          context)
                                                                      .isDark
                                                                  ? Colors.white
                                                                  : Colors.blue[
                                                                      900],
                                                          title: Text(
                                                            AppCubit.get(
                                                                    context)
                                                                .getText(
                                                                    'fruits')!,
                                                            style: TextStyle(
                                                                color: AppCubit.get(
                                                                            context)
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors.blue[
                                                                        900]),
                                                          ),
                                                          value: 3,
                                                          groupValue:
                                                              valueRadio,
                                                          onChanged:
                                                              (dynamic value) {
                                                            setState(() {
                                                              valueRadio = value
                                                                  .hashCode;
                                                              categoryController
                                                                      .text =
                                                                  'fruits';
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
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
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.blue[900],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //quantity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                AppCubit.get(context).getText('quantity')! +
                                    ':',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              Spacer(),
                              SizedBox(
                                  width: 250,
                                  child: defaultTextField(
                                    context: context,
                                    border: 30,
                                    controller: quantityController,
                                    keyboardType: TextInputType.number,
                                    label: AppCubit.get(context)
                                        .getText('quantity')!,
                                    prefixIcon: Icons.archive,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Quantity must be not empty';
                                      }
                                      return null;
                                    },
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //exp
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                AppCubit.get(context).getText('exp')! + ':',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 250,
                                child: defaultTextField(
                                    context: context,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Exp must be not empty';
                                      }
                                      return null;
                                    },
                                    border: 30,
                                    controller: expController,
                                    keyboardType: TextInputType.text,
                                    label:
                                        AppCubit.get(context).getText('exp')!,
                                    prefixIcon: Icons.calendar_today,
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.utc(2050))
                                          .then((value) {
                                        dateFormat = intl.DateFormat.y()
                                                .format(value!)
                                                .toString() +
                                            '-' +
                                            intl.DateFormat.M()
                                                .format(value)
                                                .toString() +
                                            '-' +
                                            intl.DateFormat.d()
                                                .format(value)
                                                .toString();
                                        expController.text = dateFormat;
                                      });
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                AppCubit.get(context).getText('price')! + ':',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 250,
                                child: defaultTextField(
                                    context: context,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Price must be not empty';
                                      }
                                      return null;
                                    },
                                    border: 30,
                                    controller: priceController,
                                    keyboardType: TextInputType.number,
                                    label:
                                        AppCubit.get(context).getText('price')!,
                                    prefixIcon: Icons.money),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          dividerInfo(context),
                          SizedBox(
                            height: 20,
                          ),
                          //discount
                          Row(
                            children: [
                              Text(
                                AppCubit.get(context).getText('dis1')! + ': ',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                  width: 58,
                                  height: 58,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.blue[900],
                                        fontWeight: FontWeight.w600),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '';
                                      } else if (int.parse(value) > 100) {
                                        return '';
                                      } else if (int.parse(value) > 100) {
                                        return '';
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    controller: dis1Controller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        helperStyle: TextStyle(
                                            color: Colors.blue.withOpacity(0))),
                                    maxLength: 3,
                                  )),
                              Text(
                                ' % ${AppCubit.get(context).getText('last_period')!} ',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              SizedBox(
                                  width: 58,
                                  height: 58,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.blue[900],
                                        fontWeight: FontWeight.w600),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '';
                                      } else {
                                        var a = int.parse(value);
                                        var b = int.parse(exp2Controller.text);
                                        if (a >= b) {
                                          return '';
                                        }
                                      }
                                    },
                                    decoration: InputDecoration(
                                      helperStyle: TextStyle(
                                          color: Colors.red.withOpacity(0)),
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: exp1Controller,
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                  )),
                              Text(
                                ' - ',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900],
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 58,
                                height: 58,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.blue[900],
                                      fontWeight: FontWeight.w600),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.red.withOpacity(0)),
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: exp2Controller,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                AppCubit.get(context).getText('days')!,
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                AppCubit.get(context).getText('dis2')! + ': ',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                  width: 58,
                                  height: 58,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.blue[900],
                                        fontWeight: FontWeight.w600),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '';
                                      } else if (int.parse(value) > 100) {
                                        return '';
                                      } else if (int.parse(value) > 100) {
                                        return '';
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    controller: dis2Controller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        helperStyle: TextStyle(
                                            color: Colors.blue.withOpacity(0))),
                                    maxLength: 3,
                                  )),
                              Text(
                                ' % ${AppCubit.get(context).getText('last_period')!} ',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              SizedBox(
                                  width: 58,
                                  height: 58,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.blue[900],
                                        fontWeight: FontWeight.w600),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '';
                                      } else {
                                        var a = int.parse(value);
                                        var b = int.parse(exp2Controller.text);
                                        if (a >= b) {
                                          return '';
                                        }
                                      }
                                    },
                                    decoration: InputDecoration(
                                      helperStyle: TextStyle(
                                          color: Colors.red.withOpacity(0)),
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: exp3Controller,
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                  )),
                              Text(
                                ' - ',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900],
                                    fontSize: 20),
                              ),
                              SizedBox(
                                width: 58,
                                height: 58,
                                child: TextFormField(
                                  style: TextStyle(
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.blue[900],
                                      fontWeight: FontWeight.w600),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.red.withOpacity(0)),
                                  ),
                                  textAlign: TextAlign.center,
                                  controller: exp1Controller,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                AppCubit.get(context).getText('days')!,
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                AppCubit.get(context).getText('dis3')! + ': ',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                  width: 58,
                                  height: 58,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.blue[900],
                                        fontWeight: FontWeight.w600),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '';
                                      } else if (int.parse(value) > 100) {
                                        return '';
                                      } else if (int.parse(value) > 100) {
                                        return '';
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    controller: dis3Controller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        helperStyle: TextStyle(
                                            color: Colors.blue.withOpacity(0))),
                                    maxLength: 3,
                                  )),
                              Text(
                                ' % ${AppCubit.get(context).getText('last_period')!} ',
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              ),
                              SizedBox(
                                  width: 58,
                                  height: 58,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: AppCubit.get(context).isDark
                                            ? Colors.white
                                            : Colors.blue[900],
                                        fontWeight: FontWeight.w600),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return '';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      helperStyle: TextStyle(
                                          color: Colors.red.withOpacity(0)),
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: exp3Controller,
                                    keyboardType: TextInputType.number,
                                    maxLength: 3,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                AppCubit.get(context).getText('days')!,
                                style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.white
                                        : Colors.blue[900]),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: state is AddItemSuccessStates
                              ? Colors.grey
                              : Colors.green,
                        ),
                        child: MaterialButton(
                          child: state is AddItemLoadingStates
                              ? Center(child: CircularProgressIndicator())
                              : Text(
                                  AppCubit.get(context).getText('upload')!,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                          onPressed: () {

                            if (!photoIsTake) {

                              urlToFile().then((value) {
                                _image = value;
                                if (!isUpload) {
                                  if (formAddKey.currentState!.validate()) {
                                    AddItemCubit.get(context).addItem(
                                        image: _image,
                                        name: nameController.text,
                                        category: categoryController.text,
                                        quantity: quantityController.text,
                                        exp: expController.text,
                                        price: priceController.text,
                                        dis1: dis1Controller.text,
                                        dis2: dis2Controller.text,
                                        dis3: dis3Controller.text,
                                        period1: exp1Controller.text,
                                        period2: exp2Controller.text,
                                        period3: exp3Controller.text);
                                    isUpload = true;
                                  }
                                } else if (isUpload) {
                                  Fluttertoast.showToast(
                                      msg: 'uploaded already',
                                      backgroundColor: Colors.grey);
                                }
                              });
                            } else {
                              if (!isUpload) {
                                if (formAddKey.currentState!.validate()) {
                                  AddItemCubit.get(context).addItem(
                                      image: _image,
                                      name: nameController.text,
                                      category: categoryController.text,
                                      quantity: quantityController.text,
                                      exp: expController.text,
                                      price: priceController.text,
                                      dis1: dis1Controller.text,
                                      dis2: dis2Controller.text,
                                      dis3: dis3Controller.text,
                                      period1: exp1Controller.text,
                                      period2: exp2Controller.text,
                                      period3: exp3Controller.text);
                                  isUpload = true;
                                }
                              } else if (isUpload) {
                                Fluttertoast.showToast(
                                    msg: 'uploaded already',
                                    backgroundColor: Colors.grey);
                              }
                            }
                          },
                          height: 60,
                          minWidth: double.infinity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppCubit.get(context).isDark
                              ? Colors.black
                              : Colors.blue[900],
                        ),
                        child: MaterialButton(
                          child: Text(
                            AppCubit.get(context).getText('ok')!,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ShopLayout(),
                              ),
                            );
                          },
                          height: 60,
                          minWidth: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
