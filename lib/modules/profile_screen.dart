import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/add_item_screen.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'package:shop_app/modules/info_user_item_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              shadowColor: Colors.blue[900],
              elevation: 15,
              backgroundColor: Colors.blue[300]?.withOpacity(0.5),
              automaticallyImplyLeading: false,
              toolbarHeight: 200,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.blue[900],
                      )),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90),
                            gradient: LinearGradient(
                                end: Alignment.bottomRight,
                                begin: Alignment.topRight,
                                colors: [Colors.blue, Colors.blue[900]!]),
                          ),
                        ),
                        maxRadius: 82,
                      ),
                      Stack(alignment: Alignment.bottomRight, children: [
                        CircleAvatar(
                          maxRadius: 75,
                          backgroundImage: !cubit.photoIsTake
                              ? NetworkImage(
                                  'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png')
                              : Image(image: FileImage(cubit.image1)).image,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue[900],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  splashRadius: 5,
                                  color: Colors.white,
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                              color: Colors.blue[900]
                                                  ?.withOpacity(0.3),
                                              width: double.infinity,
                                              height: 180,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color:
                                                              Colors.blue[900]),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          cubit.getImage(
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Camera',
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
                                                      width: double.infinity,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color:
                                                              Colors.blue[900]),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          cubit.getImage(
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Text(
                                                              'Gellery',
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
                                  icon: Icon(Icons.camera_alt_outlined)),
                            ),
                          ],
                        ),
                      ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'user name',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue[900],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '0933333ff33333',
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 10),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blue[900]!, width: 2),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                'baraabaraabaraabaraabaraa',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              centerTitle: true,
            ),
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) => Divider(
                color: Colors.blue[900]?.withOpacity(0.5),
                thickness: 1,
                indent: 30,
                endIndent: 30,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => InfoUserItemScreen(
                        userName: 'omar ',
                        category: 'Canned',
                        price: 2000,
                        quantity: 25,
                        userEmail: 'barddddddddddddaa@gmail.com',
                        userNumber: '+9630930716527',
                        exp: '20 - 10 - 2040',
                        image:
                            'https://producemadesimple.ca/wp-content/uploads/2015/01/orange-web-600x450.jpg',
                        itemName: 'Orange',
                        viewNum: 10,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.blue.withOpacity(0.1),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 50,
                              backgroundImage: NetworkImage(
                                  'https://producemadesimple.ca/wp-content/uploads/2015/01/orange-web-600x450.jpg'),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'orange',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '20 - 10 - 2040',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                color: Colors.blue[200]?.withOpacity(0.6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color:
                                            Colors.blue[900]?.withOpacity(0.5),
                                      ),
                                    ),
                                    Text(
                                      '5',
                                      style: TextStyle(
                                          color: Colors.blue[900]
                                              ?.withOpacity(0.5)),
                                    ),
                                  ],
                                ),
                              )),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () {
                                    commentInfo(context);
                                  },
                                  color: Colors.blue[200],
                                  child: Icon(
                                    Icons.mode_comment_outlined,
                                    color: Colors.blue[900],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue[900],
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddItem()));
              },
              child: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
