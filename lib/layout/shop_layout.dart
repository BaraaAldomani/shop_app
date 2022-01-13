import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/layout/category_screen.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/models/products_model.dart';
import 'package:shop_app/modules/add/add_item_screen.dart';
import 'package:shop_app/modules/comment/comment_screen.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class ShopLayout extends StatefulWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

ProductsModel? products;

var searchController = TextEditingController();

late LogoutModel logoutModel;
Map? favorites;
Map? likes;
int? id;

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLayoutCubit()..getProducts(),
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {
          if (state is ShopLayoutSuccessGetProductsStates) {
            if (state.productsModel.status! || !state.productsModel.status!) {
              products = state.productsModel;
              favorites = ShopLayoutCubit.get(context).fav;
              likes = ShopLayoutCubit.get(context).likes;
            }
          }
          if (state is ShopLayoutSuccessLogoutStates) {
            logoutModel = state.logoutModel;
            Fluttertoast.showToast(
                msg: logoutModel.msg, backgroundColor: Colors.green[900]);
            CacheHelper.removeData(key: 'isLogin');
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        builder: (context, state) {
          ShopLayoutCubit cubit = ShopLayoutCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              centerTitle: true,
              title: Text(
                AppCubit.get(context).getText('appBar_title')!,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              elevation: 0,
              leading: PopupMenuButton(
                offset: Offset(20, 50),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
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
                        title:
                            Text(AppCubit.get(context).getText('settings')!),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                      },
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title:
                            Text(AppCubit.get(context).getText('profile')!),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        cubit.logout();
                      },
                      leading: Icon(Icons.exit_to_app),
                      title: Text(AppCubit.get(context).getText('logout')!),
                    ),
                  ),
                ],
                child: CircleAvatar(
                  backgroundColor: Colors.white30,
                  radius: 51,
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/person-icon.png'),
                        radius: 50,
                      )),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchScreen()));
                    },
                  ),
                ),
              ],
            ),
            body: state is ShopLayoutLoadingGetProductsStates
                ? Column(
                    children: [
                      Shimmer.fromColors(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                        ),
                        baseColor: AppCubit.get(context).isDark
                            ? Colors.grey[700]!
                            : Colors.blue[300]!.withOpacity(0.3),
                        highlightColor: AppCubit.get(context).isDark
                            ? Colors.grey[500]!
                            : Colors.blue[100]!.withOpacity(0.3),
                      ),
                      Expanded(
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
                                          : Colors.blue[300]!
                                              .withOpacity(0.3),
                                      highlightColor:
                                          AppCubit.get(context).isDark
                                              ? Colors.grey[500]!
                                              : Colors.blue[100]!
                                                  .withOpacity(0.3),
                                    ),
                                  ),
                                )),
                      ),
                    ],
                  )
                : (!products!.status!)
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: AppCubit.get(context).isDark
                              ? Colors.grey
                              : Colors.blue[900]?.withOpacity(.7),
                          child: CarouselSlider(
                            items: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryScreen(
                                                category: 'vegetable',
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.black87,
                                          offset: Offset(0, 4),
                                          spreadRadius: 2,
                                          blurRadius: 30)
                                    ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            child: Image.asset(
                                              'assets/vegetable.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green
                                                .withOpacity(0.6),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(AppCubit.get(context).getText('vegetable')!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 50,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.searchByCategoryProduct(
                                      category: 'fruits');
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryScreen(
                                                  category: 'fruits')));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.black87,
                                          offset: Offset(0, 4),
                                          spreadRadius: 2,
                                          blurRadius: 30)
                                    ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            child: Image.asset(
                                              'assets/fruit.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red
                                                .withOpacity(0.6),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(AppCubit.get(context).getText('fruits')!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 50,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryScreen(
                                                  category: 'canned')));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.black87,
                                          offset: Offset(0, 4),
                                          spreadRadius: 2,
                                          blurRadius: 30)
                                    ]),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            child: Image.asset(
                                              'assets/canned.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey
                                                .withOpacity(0.6),
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(AppCubit.get(context).getText('canned')!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 50,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            options: CarouselOptions(
                              viewportFraction: 0.9,
                              disableCenter: true,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                            ),
                          ),
                        ),
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
                          height: 30,
                        ),
                        Icon(
                          Icons.south_east,
                          size: 100,
                          color: AppCubit.get(context).isDark
                              ? Colors.white30
                              : Colors.blue[900]?.withOpacity(0.5),
                        )
                      ],
                    )
                    : RefreshIndicator(
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.black
                            : Colors.blue[900],
                        color: Colors.white,
                        onRefresh: () async {
                          cubit.getProducts();
                        },
                        child: Column(
                          children: [
                            Container(
                              color: AppCubit.get(context).isDark
                                  ? Colors.grey
                                  : Colors.blue[900]?.withOpacity(.7),
                              child: CarouselSlider(
                                items: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryScreen(
                                                    category: 'vegetable',
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color: Colors.black87,
                                              offset: Offset(0, 4),
                                              spreadRadius: 2,
                                              blurRadius: 30)
                                        ]),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.asset(
                                                  'assets/vegetable.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(AppCubit.get(context).getText('vegetable')!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cubit.searchByCategoryProduct(
                                          category: 'fruits');
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryScreen(
                                                      category: 'fruits')));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color: Colors.black87,
                                              offset: Offset(0, 4),
                                              spreadRadius: 2,
                                              blurRadius: 30)
                                        ]),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.asset(
                                                  'assets/fruit.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(AppCubit.get(context).getText('fruits')!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CategoryScreen(
                                                      category: 'canned')));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        decoration: BoxDecoration(boxShadow: [
                                          BoxShadow(
                                              color: Colors.black87,
                                              offset: Offset(0, 4),
                                              spreadRadius: 2,
                                              blurRadius: 30)
                                        ]),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.asset(
                                                  'assets/canned.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(AppCubit.get(context).getText('canned')!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                options: CarouselOptions(
                                  viewportFraction: 0.9,
                                  disableCenter: true,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  enableInfiniteScroll: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                itemCount: products!.data!.length,
                                separatorBuilder: (context, index) =>
                                    dividerInfo(context),
                                itemBuilder: (context, index) =>
                                GestureDetector  (
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => InfoItemScreen(
                                          id: products!.data![index].id!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                        color: AppCubit.get(context).isDark
                                            ? Colors.black.withOpacity(0.4)
                                            : Colors.blue.withOpacity(0.1),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor:
                                                        AppCubit.get(context)
                                                                .isDark
                                                            ? Colors.grey
                                                            : Colors
                                                                .blue[900],
                                                    maxRadius: 50,
                                                    backgroundImage:
                                                        NetworkImage(products!
                                                            .data![index]
                                                            .image!)),
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
                                                        products!
                                                            .data![index].name!,
                                                        style: TextStyle(
                                                            color: AppCubit.get(
                                                                        context)
                                                                    .isDark
                                                                ? Colors.white
                                                                : Colors.blue[
                                                                    900],
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 20),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        products!.data![index]
                                                            .expiretionDate!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color:
                                                                Colors.grey),
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
                                                    products!.data![index]
                                                                .price! !=
                                                            products!
                                                                .data![index]
                                                                .pricePro!
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              '${products!.data![index].price!} \$',
                                                              style: TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .lineThrough,
                                                                  fontSize:
                                                                      15,
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
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      child: Text(
                                                        '${products!.data![index].pricePro!} \$',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      color: AppCubit
                                                                  .get(
                                                                      context)
                                                              .isDark
                                                          ? Colors.grey
                                                              .withOpacity(
                                                                  0.3)
                                                          : Colors.blue[200]
                                                              ?.withOpacity(
                                                                  0.6),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              products!
                                                                  .data![index]
                                                                  .views
                                                                  .toString(),
                                                              style:
                                                                  TextStyle(
                                                                color: AppCubit.get(
                                                                            context)
                                                                        .isDark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .blue[
                                                                            900]
                                                                        ?.withOpacity(
                                                                            0.5),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    child: MaterialButton(
                                                        onPressed: () {
                                                          cubit.changeFavorites(
                                                              products!
                                                                  .data![index]
                                                                  .id!);
                                                          favorites![products!
                                                                  .data![index]
                                                                  .id] =
                                                              !favorites![
                                                                  products!
                                                                      .data![
                                                                          index]
                                                                      .id];
                                                          favorites![products!
                                                                  .data![index]
                                                                  .id]
                                                              ? likes![products!
                                                                  .data![index]
                                                                  .id]++
                                                              : likes![products!
                                                                  .data![index]
                                                                  .id]--;
                                                        },
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.black
                                                            : Colors
                                                                .blue[200],
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            favorites![products!
                                                                    .data![
                                                                        index]
                                                                    .id]
                                                                ? Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: AppCubit.get(context).isDark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .blue[900],
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: AppCubit.get(context).isDark
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .blue[900],
                                                                  ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      8.0),
                                                              child: favorites![
                                                                      products!
                                                                          .data![index]
                                                                          .id]
                                                                  ? Text(
                                                                      '${likes![products!.data![index].id]}',
                                                                      style: TextStyle(
                                                                          color: AppCubit.get(context).isDark
                                                                              ? Colors.white
                                                                              : Colors.blue[900]),
                                                                    )
                                                                  : Text(
                                                                      '${likes![products!.data![index].id]}',
                                                                      style: TextStyle(
                                                                          color: AppCubit.get(context).isDark
                                                                              ? Colors.white
                                                                              : Colors.blue[900]),
                                                                    ),
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                      child: MaterialButton(
                                                    onPressed: () {

                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CommentScreen(id: products!
                                                          .data![index].id!,)));
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
                                                  )),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
