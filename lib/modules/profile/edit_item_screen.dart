import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shop_app/modules/profile/cubit/states.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class EditItem extends StatefulWidget {
  dynamic image;
  String name;
  int id;
  String category;
  String quantity;
  String price;
  String exp;
  String dis1;
  String dis2;
  String dis3;
  String period1;
  String period2;
  String period3;

  EditItem({
    Key? key,
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
    required this.exp,
    required this.quantity,
    required this.dis1,
    required this.dis2,
    required this.dis3,
    required this.period1,
    required this.period2,
    required this.period3,
  }) : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

var editNameController = TextEditingController();
var editCategoryController = TextEditingController();
var editQuantityController = TextEditingController();
var editPriceController = TextEditingController();
var editExpController = TextEditingController();
var editDis1Controller = TextEditingController();
var editDis2Controller = TextEditingController();
var editDis3Controller = TextEditingController();
var editExp1Controller = TextEditingController();
var editExp2Controller = TextEditingController();
var editExp3Controller = TextEditingController();

String itemImage =
    'https://cdn.pixabay.com/photo/2016/01/05/13/58/apple-1122537__340.jpg';

class _EditItemState extends State<EditItem> {
  @override
  void initState() {
    editNameController = TextEditingController(text: widget.name);
    editCategoryController = TextEditingController(text: widget.category);
    editQuantityController = TextEditingController(text: widget.quantity);
    editPriceController = TextEditingController(text: widget.price);
    editExpController = TextEditingController(text: widget.exp);
    editDis1Controller = TextEditingController(text: widget.dis1);
    editDis2Controller = TextEditingController(text: widget.dis2);
    editDis3Controller = TextEditingController(text: widget.dis3);
    editExp1Controller = TextEditingController(text: widget.period1);
    editExp1Controller = TextEditingController(text: widget.period2);
    editExp1Controller = TextEditingController(text: widget.period1);
    editExp2Controller = TextEditingController(text: widget.period2);
    editExp3Controller = TextEditingController(text: widget.period3);
    itemImage = widget.image;

    super.initState();
  }

  var formEditKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();
  late File _image;

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

  Future<File> urlToFile() async {
    var rng = Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(Uri.parse(widget.image));
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  int valueRadio = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is EditItemSuccessStates){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                builder: (context) =>ProfileScreen()));

          }
        },
        builder: (context, state) {
          return Directionality(
            textDirection: AppCubit.get(context).isEnglish? TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              body: Form(
                key: formEditKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          AppCubit.get(context).getText('appBar_edit_title')!,
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(180),
                                        gradient: LinearGradient(
                                            end: Alignment.bottomRight,
                                            begin: Alignment.topRight,
                                            colors: [
                                              AppCubit.get(context).isDark?Colors.white:Colors.blue,
                                              AppCubit.get(context).isDark?Colors.grey[900]!:Colors.blue[900]!,
                                            ]
                                        ),
                                      ),
                                    ),
                                    maxRadius: 160),
                                CircleAvatar(
                                  backgroundImage: !photoIsTake
                                      ? NetworkImage(itemImage)
                                      : Image(image: FileImage(_image)).image,
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
                                '${AppCubit.get(context).getText('photo')!} :',
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
                                    color:AppCubit.get(context).isDark? Colors.black:Colors.blue[900],
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
                                ),
                              ),
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
                                AppCubit.get(context).getText('name')!,
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
                                    controller: editNameController,
                                    keyboardType: TextInputType.text,
                                    label: AppCubit.get(context).getText('name')!,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Name must be not empty';
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icons.person_outline_rounded),
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
                                AppCubit.get(context).getText('category')! + ':',
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
                                    controller: editCategoryController,
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    label: AppCubit.get(context)
                                        .getText('category')!,
                                    prefixIcon: Icons.category_outlined,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) => Container(
                                                    color: Colors.blue[900]
                                                        ?.withOpacity(0.1),
                                                    child: Dialog(
                                                      child: SizedBox(
                                                        height: 200,
                                                        child: Column(
                                                          children: [
                                                            RadioListTile(
                                                              activeColor: Colors
                                                                  .blue[900],
                                                              title: Text(
                                                                AppCubit.get(
                                                                        context)
                                                                    .getText(
                                                                        'canned')!,
                                                                style: TextStyle(
                                                                    color: !AppCubit.get(
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
                                                              onChanged: (dynamic
                                                                  value) {
                                                                setState(() {
                                                                  valueRadio = value
                                                                      .hashCode;
                                                                  editCategoryController
                                                                          .text =
                                                                      'Canned';
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                });
                                                              },
                                                            ),
                                                            RadioListTile(
                                                                activeColor:
                                                                    Colors.blue[
                                                                        900],
                                                                title: Text(
                                                                  AppCubit.get(
                                                                          context)
                                                                      .getText(
                                                                          'vegetable')!,
                                                                  style: TextStyle(
                                                                      color: !AppCubit.get(
                                                                                  context)
                                                                              .isDark
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .blue[900]),
                                                                ),
                                                                value: 2,
                                                                groupValue:
                                                                    valueRadio,
                                                                onChanged:
                                                                    (dynamic
                                                                        value) {
                                                                  setState(() {
                                                                    editCategoryController
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
                                                              activeColor: Colors
                                                                  .blue[900],
                                                              title: Text(
                                                                AppCubit.get(
                                                                        context)
                                                                    .getText(
                                                                        'fruits')!,
                                                                style: TextStyle(
                                                                    color: !AppCubit.get(
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
                                                              onChanged: (dynamic
                                                                  value) {
                                                                setState(() {
                                                                  valueRadio = value
                                                                      .hashCode;
                                                                  editCategoryController
                                                                          .text =
                                                                      'Fruit';
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
                                                : Colors.blue[900]))),
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
                                '${AppCubit.get(context).getText('quantity')!} :',
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
                                    controller: editQuantityController,
                                    keyboardType: TextInputType.number,
                                    label: AppCubit.get(context)
                                        .getText('quantity')!,
                                    prefixIcon: Icons.archive_outlined,
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
                                '${AppCubit.get(context).getText('exp')!} :',
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
                                    enable: false,
                                    border: 30,
                                    controller: editExpController,
                                    keyboardType: TextInputType.text,
                                    label: AppCubit.get(context).getText('exp')!,
                                    prefixIcon: Icons.date_range_outlined,
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.utc(2050))
                                          .then((value) =>
                                              editExpController.text =
                                                  intl.DateFormat.yMd()
                                                      .format(value!)
                                                      .toString());
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
                                '${AppCubit.get(context).getText('price')!} :',
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
                                    controller: editPriceController,
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
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text(
                                '${AppCubit.get(context).getText('dis1')!} :',
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
                                      }else if(int.parse(value)>100){
                                        return '';
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    controller: editDis1Controller,
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
                                      var a = int.parse(value!);
                                      var b = int.parse(editExp2Controller.text);
                                      if (value.isEmpty) {
                                        return '';
                                      } else if (a >= b) {
                                        return '';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      helperStyle: TextStyle(
                                          color: Colors.red.withOpacity(0)),
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: editExp1Controller,
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
                                  controller: editExp2Controller,
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
                                '${AppCubit.get(context).getText('dis2')!} :',
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
                                      }else if(int.parse(value)>100){
                                        return '';
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    controller: editDis2Controller,
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
                                      var a = int.parse(value!);
                                      var b = int.parse(editExp1Controller.text);
                                      if (value.isEmpty) {
                                        return '';
                                      } else if (a >= b) {
                                        return '';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      helperStyle: TextStyle(
                                          color: Colors.red.withOpacity(0)),
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: editExp3Controller,
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
                                  controller: editExp1Controller,
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
                                '${AppCubit.get(context).getText('dis3')!} :',
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
                                      }else if(int.parse(value)>100){
                                        return '';
                                      }
                                    },
                                    textAlign: TextAlign.center,
                                    controller: editDis3Controller,
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
                                    controller: editExp3Controller,
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
                          color:AppCubit.get(context).isDark ?Colors.black:Colors.blue[900],
                        ),
                        child: MaterialButton(
                          child: Text(
                            AppCubit.get(context).getText('edit')!,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            if (!photoIsTake) {
                              urlToFile().then((value) {
                                _image = value;
                                if (formEditKey.currentState!.validate()) {
                                  ProfileCubit.get(context).editItem(
                                      id: widget.id,
                                      image: _image,
                                      name: editNameController.text,
                                      category: editCategoryController.text,
                                      quantity: editQuantityController.text,
                                      price: editPriceController.text,
                                      dis1: editDis1Controller.text,
                                      dis2: editDis2Controller.text,
                                      dis3: editDis3Controller.text,
                                      period1: editExp1Controller.text,
                                      period2: editExp2Controller.text,
                                      period3: editExp3Controller.text);
                                }
                              });
                            }else
                            if (formEditKey.currentState!.validate()) {
                              ProfileCubit.get(context).editItem(
                                  id: widget.id,
                                  image: _image,
                                  name: editNameController.text,
                                  category: editCategoryController.text,
                                  quantity: editQuantityController.text,
                                  price: editPriceController.text,
                                  dis1: editDis1Controller.text,
                                  dis2: editDis2Controller.text,
                                  dis3: editDis3Controller.text,
                                  period1: editExp1Controller.text,
                                  period2: editExp2Controller.text,
                                  period3: editExp3Controller.text);
                            }
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
