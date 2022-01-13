import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/comment/comment_screen.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
late SearchModel search;

class _CategoryScreenState extends State<CategoryScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopLayoutCubit()..searchByCategoryProduct(category: widget.category),
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {
          if (state is ShopLayoutSuccessSearchByCategoryStates) {
            search = state.searchByCategoryModel;
            if (search.status!) {
              print(search.data!.length);
            }
          }

        },
        builder: (context, state) {
          return Directionality(
            textDirection: AppCubit.get(context).isEnglish
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: Text(AppCubit.get(context).getText(widget.category)!),
                toolbarHeight: 70,
                centerTitle: true,
              ),
              body: state is ShopLayoutLoadingSearchByCategoryStates
                  ? ListView.builder(
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Colors.white,
                                            child: SizedBox(
                                              height: 20,
                                              width: 200,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Colors.white,
                                            child: SizedBox(
                                              height: 20,
                                              width: 200,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                          ))
                  : (!search.status!)
                      ? Center(
                          child: Text(
                            AppCubit.get(context)
                                .getText('not_found_any_product')!,
                            style: TextStyle(
                                fontSize: 30,
                                color: AppCubit.get(context).isDark
                                    ? Colors.grey
                                    : Colors.blue[900]?.withOpacity(0.3)),
                          ),
                        )
                      : RefreshIndicator(
                          backgroundColor: AppCubit.get(context).isDark
                              ? Colors.black
                              : Colors.blue[900],
                          color: Colors.white,
                          onRefresh: () async {
                            ShopLayoutCubit.get(context)
                                .searchByCategoryProduct(
                                    category: widget.category);
                          },
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  itemCount: search.data!.length,
                                  separatorBuilder: (context, index) =>
                                      dividerInfo(context),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => InfoItemScreen(
                                            id: search.data![index].id!,
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
                                              ? Colors.blue.withOpacity(0)
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
                                                            : Colors.blue[900],
                                                    maxRadius: 50,
                                                    backgroundImage: search
                                                                .data![index]
                                                                .image!
                                                                .length >
                                                            10
                                                        ? NetworkImage(search
                                                            .data![index].image!)
                                                        : NetworkImage(
                                                            'https://semantic-ui.com/images/wireframe/image.png'),
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
                                                          search
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
                                                          search.data![index]
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
                                                      search.data![index]
                                                                  .price !=
                                                              search.data![index]
                                                                  .pricePro
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                '${search.data![index].price} \$',
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
                                                          '${search.data![index].pricePro} \$',
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
                                                padding: EdgeInsets.all(5),
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
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .blue[
                                                                            900]
                                                                        ?.withOpacity(
                                                                            0.5),
                                                              ),
                                                            ),
                                                            Text(
                                                              search.data![index]
                                                                  .views
                                                                  .toString(),
                                                              style: TextStyle(
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
                                                          ShopLayoutCubit.get(
                                                                  context)
                                                              .changeFavorites(
                                                                  search
                                                                      .data![
                                                                          index]
                                                                      .id!);
                                                          favorites![search
                                                                  .data![index]
                                                                  .id] =
                                                              !favorites![search
                                                                  .data![index]
                                                                  .id];
                                                          favorites![search
                                                              .data![index]
                                                              .id]
                                                              ? likes![search
                                                              .data![index]
                                                              .id]++
                                                              : likes![search
                                                              .data![index]
                                                              .id]--;
                                                        },
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.black
                                                            : Colors.blue[200],
                                                        child:
                                                            Row(children: [
                                                              favorites![search
                                                                  .data![index]
                                                                  .id]
                                                                  ? Icon(
                                                                Icons
                                                                    .favorite,
                                                                color: AppCubit.get(
                                                                    context)
                                                                    .isDark
                                                                    ? Colors
                                                                    .white
                                                                    : Colors
                                                                    .blue[900],
                                                              )
                                                                  : Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                color: AppCubit.get(
                                                                    context)
                                                                    .isDark
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
                                                                search
                                                                    .data![index]
                                                                    .id]
                                                                    ? Text(
                                                                  '${likes![search.data![index].id]}',
                                                                  style: TextStyle(
                                                                      color: AppCubit.get(context).isDark
                                                                          ? Colors.white
                                                                          : Colors.blue[900]),
                                                                )
                                                                    : Text(
                                                                  '${likes![search.data![index].id]}',
                                                                  style: TextStyle(
                                                                      color: AppCubit.get(context).isDark
                                                                          ? Colors.white
                                                                          : Colors.blue[900]),
                                                                ),
                                                              )
                                                            ],)
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Expanded(
                                                        child: MaterialButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CommentScreen(id: search
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
            ),
          );
        },
      ),
    );
  }
}
