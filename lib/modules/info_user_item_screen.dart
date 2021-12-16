import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/edit_item_screen.dart';
import 'package:shop_app/modules/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class InfoUserItemScreen extends StatefulWidget {
  String image;
  String itemName;
  int viewNum;
  String exp;
  String category;
  int quantity;
  int price;
  String userNumber;
  String userEmail;
  String userName;
  InfoUserItemScreen(
      {Key? key,
      required this.image,
      required this.itemName,
      required this.viewNum,
      required this.exp,
      required this.category,
      required this.quantity,
      required this.price,
      required this.userNumber,
      required this.userName,
      required this.userEmail})
      : super(key: key);

  @override
  State<InfoUserItemScreen> createState() => _InfoUserItemScreenState();
}

var commentController = TextEditingController();

class _InfoUserItemScreenState extends State<InfoUserItemScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) => {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              body: Container(
                color: Colors.blue[300]?.withOpacity(0.3),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.blue[900],
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        },
                      ),
                      snap: false,
                      pinned: false,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          widget.itemName,
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 16.0,
                          ),
                        ),
                        background: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, imageUrl, download) {
                            if (download.progress != null) {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                                value: 5,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ));
                            }
                            return Center(
                                child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ));
                          },
                          imageUrl: widget.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      expandedHeight: 300,
                      backgroundColor: Colors.blue[900],
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IconButton(
                            splashColor: Colors.orange,
                            icon: Icon(
                              Icons.edit,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditItem()));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: IconButton(
                            splashColor: Colors.red[900],
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[900],
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red[900],
                                      fontSize: 30,
                                    ),
                                  ),
                                  content: Text('Are you sure?'),
                                  actions: [
                                    MaterialButton(
                                      splashColor: Colors.blue[900],
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 20),
                                      ),
                                    ),
                                    MaterialButton(
                                      splashColor: Colors.red[900],
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileScreen()));
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(
                                            color: Colors.red[900],
                                            fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.remove_red_eye,
                              color: Colors.blue[900],
                            ),
                            title: Text(
                              '${widget.viewNum}',
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Item information:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[900]),
                                  ),
                                  SizedBox(
                                    height: 250,
                                    width: 300,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        info(key: 'Exp:', value: widget.exp),
                                        info(
                                            key: 'Category:',
                                            value: widget.category),
                                        info(
                                            key: 'Quantity:',
                                            value: '${widget.quantity}'),
                                        info(
                                            key: 'Price:',
                                            value: '${widget.price}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.person,
                              color: Colors.blue[900],
                            ),
                            title: Text(
                              widget.userName,
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Phone number:',
                                        style:
                                            TextStyle(color: Colors.blue[900]),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          widget.userNumber,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                    SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Email Address:',
                                        style:
                                            TextStyle(color: Colors.blue[900]),
                                      ),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          widget.userEmail,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
