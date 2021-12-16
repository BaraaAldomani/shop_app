import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/add_item_screen.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/profile_screen.dart';
import 'package:shop_app/modules/search_bar.dart';
import 'package:shop_app/modules/settings.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ShopLayout extends StatefulWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

var searchController = TextEditingController();

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              centerTitle: true,
              title: Text(
                'Shop',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              leading: GestureDetector(
                onTap: () => {},
                child: PopupMenuButton(
                  offset: Offset(20, 50),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Settings(),
                              ],
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                        },
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Profile'),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        leading: Icon(Icons.exit_to_app),
                        title: Text('Logout'),
                      ),
                    ),
                  ],
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://producemadesimple.ca/wp-content/uploads/2015/01/orange-web-600x450.jpg'),
                      radius: 50,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // cubit.changeIsSearch(cubit.isSearching);
                    },
                    child: SearchBar(),
                  ),
                ),
              ],
            ),
            body: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) => dividerInfo(),
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InfoItemScreen(
                              userName: 'omar alhakeem',
                              category: 'Canned',
                              price: 2000,
                              quantity: 25,
                              userEmail: 'barddddddddddddaa@gmail.com',
                              userNumber: '+9630930716527',
                              exp: '20 - 10 - 2040',
                              image:
                                  'https://media.istockphoto.com/photos/orange-picture-id185284489',
                              itemName: 'Orange',
                              viewNum: 10,
                            )));
                  },
                  child: Container(
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
                                          color: Colors.blue[900]
                                              ?.withOpacity(0.5),
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
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      cubit.putLikeItem(cubit.isFav);
                                    },
                                    color: Colors.blue[200],
                                    child: cubit.isFav
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.blue[900],
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            color: Colors.blue[900],
                                          ),
                                  ),
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
                                )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            floatingActionButton: FloatingActionButton(
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
