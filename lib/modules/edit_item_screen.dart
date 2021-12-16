import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class EditItem extends StatefulWidget {
  EditItem({Key? key}) : super(key: key);
  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  var editnameController = TextEditingController(text: 'varaaaaaaa');
  var editcategoryController = TextEditingController(text: 'Canned');
  var editquantityController = TextEditingController(text: '25');
  var editpriceController = TextEditingController(text: '2500');
  var editexpController = TextEditingController(text: '20 - 10 - 2022');
  var editdis1Controller = TextEditingController(text: '20');
  var editdis2Controller = TextEditingController(text: '40');
  var editdis3Controller = TextEditingController(text: '60');
  var editexp1Controller = TextEditingController(text: '10');
  var editexp2Controller = TextEditingController(text: '20');
  var editexp3Controller = TextEditingController(text: '5');
  var editexp4Controller = TextEditingController();
  var editexp5Controller = TextEditingController(text: '10');
  String itemImage =
      'https://cdn.pixabay.com/photo/2016/01/05/13/58/apple-1122537__340.jpg';
  var formAddKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  late File _image;
  bool photoIsTake = false;

  Future getImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source);
    if (image == null) return;
    final imageTemporoy = File(image.path);
    setState(() {
      _image = imageTemporoy;
      photoIsTake = true;
    });
  }

  int valueRadio = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formAddKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'Edit Item',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]),
                ),
              ),
            ),
            dividerInfo(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Text('Name:'),
                      Spacer(),
                      SizedBox(
                        width: 250,
                        child: defaultTextField(
                            border: 30,
                            controller: editnameController,
                            keyboardType: TextInputType.text,
                            label: 'Name',
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
                      Text('Category:'),
                      Spacer(),
                      SizedBox(
                        width: 250,
                        child: defaultTextField(
                            border: 30,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Category must be not empty';
                              }
                              return null;
                            },
                            controller: editcategoryController,
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            label: 'Category',
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
                                                      activeColor:
                                                          Colors.blue[900],
                                                      title: Text('Canned'),
                                                      value: 1,
                                                      groupValue: valueRadio,
                                                      onChanged:
                                                          (dynamic value) {
                                                        setState(() {
                                                          valueRadio =
                                                              value.hashCode;
                                                          editcategoryController
                                                              .text = 'Canned';
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                    ),
                                                    RadioListTile(
                                                        activeColor:
                                                            Colors.blue[900],
                                                        title:
                                                            Text('Vegetable'),
                                                        value: 2,
                                                        groupValue: valueRadio,
                                                        onChanged:
                                                            (dynamic value) {
                                                          setState(() {
                                                            editcategoryController
                                                                    .text =
                                                                'vegetable';
                                                            valueRadio =
                                                                value.hashCode;
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });
                                                        }),
                                                    RadioListTile(
                                                      activeColor:
                                                          Colors.blue[900],
                                                      title: Text('Fruit'),
                                                      value: 3,
                                                      groupValue: valueRadio,
                                                      onChanged:
                                                          (dynamic value) {
                                                        setState(() {
                                                          valueRadio =
                                                              value.hashCode;
                                                          editcategoryController
                                                              .text = 'Fruit';
                                                          Navigator.of(context)
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
                                  color: Colors.blue[900],
                                ))),
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
                      Text('Quantity:'),
                      Spacer(),
                      SizedBox(
                          width: 250,
                          child: defaultTextField(
                            hint: '25',
                            border: 30,
                            controller: editquantityController,
                            keyboardType: TextInputType.number,
                            label: 'Quantity',
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
                      Text('Exp:'),
                      Spacer(),
                      SizedBox(
                        width: 250,
                        child: defaultTextField(
                            enable: false,
                            border: 30,
                            controller: editexpController,
                            keyboardType: TextInputType.text,
                            label: 'Expirtion',
                            prefixIcon: Icons.date_range_outlined,
                            readOnly: true,
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(2050))
                                  .then((value) => editexpController.text =
                                      DateFormat.yMd()
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
                      Text('Price:'),
                      Spacer(),
                      SizedBox(
                        width: 250,
                        child: defaultTextField(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Price must be not empty';
                              }
                              return null;
                            },
                            hint: '25',
                            border: 30,
                            controller: editpriceController,
                            keyboardType: TextInputType.number,
                            label: 'Price',
                            prefixIcon: Icons.money),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.blue[900], maxRadius: 80),
                        CircleAvatar(
                          backgroundImage: !photoIsTake
                              ? NetworkImage(itemImage)
                              : Image(image: FileImage(_image)).image,
                          maxRadius: 75,
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
                      Text('Photo:'),
                      Spacer(),
                      SizedBox(
                          width: 250,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue[900],
                            ),
                            child: MaterialButton(
                              child: Text('Pick Image',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                          color: Colors.blue[900]
                                              ?.withOpacity(0.3),
                                          width: double.infinity,
                                          height: 180,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.blue[900]),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      getImage(
                                                          ImageSource.camera);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .photo_camera_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          'Camera',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                  width: double.infinity,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.blue[900]),
                                                  child: MaterialButton(
                                                    onPressed: () {
                                                      getImage(
                                                          ImageSource.gallery);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.photo_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          'Gellery',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                  dividerInfo(),
                  //discount
                  Row(
                    children: [
                      Text('discount 1:'),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          width: 58,
                          height: 58,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: editdis1Controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                helperStyle: TextStyle(
                                    color: Colors.blue.withOpacity(0))),
                            maxLength: 3,
                          )),
                      Text(' % Last '),
                      SizedBox(
                          width: 58,
                          height: 58,
                          child: TextField(
                            decoration: InputDecoration(
                              helperStyle:
                                  TextStyle(color: Colors.red.withOpacity(0)),
                            ),
                            textAlign: TextAlign.center,
                            controller: editexp1Controller,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                          )),
                      Text(
                        ' - ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 58,
                        height: 58,
                        child: TextField(
                          decoration: InputDecoration(
                            helperStyle:
                                TextStyle(color: Colors.red.withOpacity(0)),
                          ),
                          textAlign: TextAlign.center,
                          controller: editexp2Controller,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Days')
                    ],
                  ),
                  Row(
                    children: [
                      Text('discount 2:'),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          width: 58,
                          height: 58,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: editdis2Controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                helperStyle: TextStyle(
                                    color: Colors.blue.withOpacity(0))),
                            maxLength: 3,
                          )),
                      Text(' % Last '),
                      SizedBox(
                          width: 58,
                          height: 58,
                          child: TextField(
                            decoration: InputDecoration(
                              helperStyle:
                                  TextStyle(color: Colors.red.withOpacity(0)),
                            ),
                            textAlign: TextAlign.center,
                            controller: editexp3Controller,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                          )),
                      Text(
                        ' - ',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 58,
                        height: 58,
                        child: TextField(
                          decoration: InputDecoration(
                            helperStyle:
                                TextStyle(color: Colors.red.withOpacity(0)),
                          ),
                          textAlign: TextAlign.center,
                          controller: editexp1Controller,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Days')
                    ],
                  ),
                  Row(
                    children: [
                      Text('discount 3:'),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                          width: 58,
                          height: 58,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: editdis3Controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                helperStyle: TextStyle(
                                    color: Colors.blue.withOpacity(0))),
                            maxLength: 3,
                          )),
                      Text(' % Last '),
                      SizedBox(
                          width: 58,
                          height: 58,
                          child: TextField(
                            decoration: InputDecoration(
                              helperStyle:
                                  TextStyle(color: Colors.red.withOpacity(0)),
                            ),
                            textAlign: TextAlign.center,
                            controller: editexp3Controller,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Days')
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
                  color: Colors.blue[900],
                ),
                child: MaterialButton(
                  child: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    if (formAddKey.currentState!.validate()) {
                      Navigator.of(context).pop();
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
    );
  }
}
