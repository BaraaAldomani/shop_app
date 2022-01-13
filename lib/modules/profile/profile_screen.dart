import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/modules/add/add_item_screen.dart';
import 'package:shop_app/modules/comment/comment_screen.dart';
import 'package:shop_app/modules/profile/cubit/cubit.dart';
import 'package:shop_app/modules/profile/cubit/states.dart';
import 'package:shop_app/modules/profile/info_user_item_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

ProfileModel? profile;

var profileCommentController = TextEditingController();

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserInfo(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileGetUserInfoSuccessStates) {
            if (state.profileModel.status! || !state.profileModel.status!) {
              profile = ProfileCubit.get(context).profileModel;
            }
          }
        },
        builder: (context, state) {
          return state is ProfileGetUserInfoLoadingStates
              ? Scaffold(
                  appBar: AppBar(
                    shadowColor: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.blue[900],
                    elevation: 15,
                    backgroundColor: AppCubit.get(context).isDark
                        ? Colors.black
                        : Colors.blue[300]?.withOpacity(0.5),
                    automaticallyImplyLeading: false,
                    toolbarHeight: 200,
                    title: Shimmer.fromColors(
                      child: Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 70,
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 20,
                                    width: 150,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 20,
                                    width: 150,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 20,
                                    width: 150,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      baseColor: AppCubit.get(context).isDark
                          ? Colors.grey[700]!
                          : Colors.blue[400]!.withOpacity(0.3),
                      highlightColor: AppCubit.get(context).isDark
                          ? Colors.grey[500]!
                          : Colors.white.withOpacity(0.3),
                    ),
                    centerTitle: true,
                  ),
                  body: Center(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Shimmer.fromColors(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 50,
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.white,
                                              child: SizedBox(
                                                height: 20,
                                                width: 200,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.white,
                                              child: SizedBox(
                                                height: 20,
                                                width: 200,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.white,
                                              child: SizedBox(
                                                height: 20,
                                                width: 200,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  baseColor: AppCubit.get(context).isDark
                                      ? Colors.grey[700]!
                                      : Colors.blue[300]!.withOpacity(0.3),
                                  highlightColor: AppCubit.get(context).isDark
                                      ? Colors.grey[500]!
                                      : Colors.blue[100]!.withOpacity(0.3),
                                ),
                              ),
                            )),
                  ),
                )
              : (!profile!.status!)
                  ? Scaffold(
                      appBar: AppBar(
                        shadowColor: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.blue[900],
                        elevation: 15,
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.black
                            : Colors.blue[300]?.withOpacity(0.5),
                        automaticallyImplyLeading: false,
                        toolbarHeight: 200,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShopLayout()));
                                },
                                icon: Icon(
                                  Icons.arrow_back_outlined,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.blue[900],
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
                                  maxRadius: 82,
                                ),
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                          maxRadius: 75,
                                          backgroundImage: AssetImage(
                                              'assets/person-icon.png')),
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
                                        profile!.sellerDetails!.name!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppCubit.get(context).isDark
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.blue[900],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        profile!.sellerDetails!.phoneNo!,
                                        style: TextStyle(
                                            color:
                                                AppCubit.get(context).isDark
                                                    ? Colors.black
                                                    : Colors.blue[900],
                                            fontSize: 10),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          profile!.sellerDetails!.email!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                AppCubit.get(context).isDark
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.blue[900],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        centerTitle: true,
                      ),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.error,
                                size: 50,
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.blue[900],
                              ),
                            ),
                            Text(
                              AppCubit.get(context)
                                  .getText('no_product_to_show')!,
                              style: TextStyle(
                                fontSize: 20,
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.blue[900],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              AppCubit.get(context)
                                  .getText('create_one_now')!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.blue[900],
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Icon(
                              Icons.south_east,
                              size: 100,
                              color: AppCubit.get(context).isDark
                                  ? Colors.white30
                                  : Colors.blue[900]?.withOpacity(0.5),
                            )
                          ],
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.black
                            : Colors.blue[900],
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddItem()));
                        },
                        child: Icon(Icons.add),
                      ),
                    )
                  : Scaffold(
                      appBar: AppBar(
                        shadowColor: AppCubit.get(context).isDark
                            ? Colors.white
                            : Colors.blue[900],
                        elevation: 15,
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.black
                            : Colors.blue[300]?.withOpacity(0.5),
                        automaticallyImplyLeading: false,
                        toolbarHeight: 200,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ShopLayout()));
                                },
                                icon: Icon(
                                  Icons.arrow_back_outlined,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.blue[900],
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
                                  maxRadius: 82,
                                ),
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                          maxRadius: 75,
                                          backgroundImage: AssetImage(
                                              'assets/person-icon.png')),
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
                                        profile!.sellerDetails!.name!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppCubit.get(context).isDark
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.blue[900],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        profile!.sellerDetails!.phoneNo!,
                                        style: TextStyle(
                                            color:
                                                AppCubit.get(context).isDark
                                                    ? Colors.black
                                                    : Colors.blue[900],
                                            fontSize: 10),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          profile!.sellerDetails!.email!,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                AppCubit.get(context).isDark
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppCubit.get(context).isDark
                                          ? Colors.white
                                          : Colors.blue[900],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        centerTitle: true,
                      ),
                      body: state is ProfileGetUserInfoLoadingStates
                          ? null
                          : RefreshIndicator(
                              backgroundColor: AppCubit.get(context).isDark
                                  ? Colors.black
                                  : Colors.blue[900],
                              color: Colors.white,
                              onRefresh: () async {
                                ProfileCubit.get(context).getUserInfo();
                              },
                              child: ListView.separated(
                                dragStartBehavior: DragStartBehavior.start,
                                itemCount: profile!.data!.length,
                                separatorBuilder: (context, index) => Divider(
                                  color: AppCubit.get(context).isDark
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.blue[900]?.withOpacity(0.5),
                                  thickness: 1,
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InfoUserItemScreen(
                                          id: profile!.data![index].id!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: AppCubit.get(context).isDark
                                        ? Colors.black.withOpacity(0.4)
                                        : Colors.blue.withOpacity(0.1),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                maxRadius: 50,
                                                backgroundImage: NetworkImage(
                                                    profile!
                                                        .data![index].image!),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    Text(
                                                      profile!
                                                          .data![index].name!,
                                                      style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors
                                                                  .blue[900],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      profile!.data![index]
                                                          .expiretionDate!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  profile!.data![index]
                                                              .price !=
                                                          profile!.data![index]
                                                              .pricePro
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            '${profile!.data![index].price} \$',
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .red),
                                                          ),
                                                        )
                                                      : Container(),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '${profile!.data![index].pricePro} \$',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.green),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  color: AppCubit.get(context)
                                                          .isDark
                                                      ? Colors.grey
                                                          .withOpacity(0.3)
                                                      : Colors.blue[200]
                                                          ?.withOpacity(0.6),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Icon(
                                                          Icons
                                                              .remove_red_eye,
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors
                                                                  .blue[900]
                                                                  ?.withOpacity(
                                                                      0.5),
                                                        ),
                                                      ),
                                                      Text(
                                                        profile!
                                                            .data![index].views
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: AppCubit.get(
                                                                      context)
                                                                  .isDark
                                                              ? Colors.white
                                                              : Colors
                                                                  .blue[900]
                                                                  ?.withOpacity(
                                                                      0.5),
                                                        ),
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
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      CommentScreen(
                                                                        id: profile!
                                                                            .data![index]
                                                                            .id!,
                                                                      )));
                                                    },
                                                    color:
                                                        AppCubit.get(context)
                                                                .isDark
                                                            ? Colors.black
                                                            : Colors
                                                                .blue[200],
                                                    child: Icon(
                                                      Icons
                                                          .mode_comment_outlined,
                                                      color: AppCubit.get(
                                                                  context)
                                                              .isDark
                                                          ? Colors.white
                                                          : Colors.blue[900],
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
                            ),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.black
                            : Colors.blue[900],
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddItem()));
                        },
                        child: Icon(Icons.add),
                      ),
                    );
        },
      ),
    );
  }
}
