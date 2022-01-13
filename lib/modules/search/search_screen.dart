import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

import '../info_item_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
late SearchModel searchModel;
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  bool isSearchByName = true;
  bool isSearchByDate = false;
  String? dateFormat;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is SearchSuccessStates) {
            searchModel = state.searchModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              title: Theme(
                data: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                )),
                child: TextFormField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: isSearchByName ? AppCubit.get(context).getText('search_something') : AppCubit.get(context).getText('Search_by_date'),
                    hintStyle: TextStyle(
                        color: AppCubit.get(context).isDark
                            ? Colors.grey
                            : Colors.blue[100]),
                  ),
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton(
                      offset: Offset(20, 50),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              isSearchByDate = false;
                              isSearchByName = true;
                              Navigator.of(context).pop();
                            },
                            title: Text(AppCubit.get(context)
                                .getText('search_by_name')!),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              isSearchByDate = true;
                              isSearchByName = false;
                              Navigator.of(context).pop();
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
                                    intl.DateFormat.M().format(value).toString() +
                                    '-' +
                                    intl.DateFormat.d().format(value).toString();

                                searchController.text = dateFormat!;
                              });
                            },
                            title: Text(AppCubit.get(context)
                                .getText('search_by_date')!),
                          ),
                        ),
                      ],
                      child: Icon(Icons.filter_list),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          print(searchController.text);
                          if (isSearchByName) {
                            SearchCubit.get(context)
                                .searchProduct(name: searchController.text);
                          }
                          if (isSearchByDate) {
                            SearchCubit.get(context)
                                .searchProduct(date: searchController.text);
                          }
                        },
                        icon: Icon(Icons.search),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: state is SearchInitialStates
                ? Center(
                    child: Text(
                    AppCubit.get(context).getText('search')!,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: AppCubit.get(context).isDark
                              ? Colors.grey
                              : Colors.blue[900]?.withOpacity(0.2)),
                    ),
                  )
                : state is SearchLoadingStates
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
                    : (state is SearchSuccessStates && state.searchModel.status!)
                        ? ListView.separated(
                            itemCount: searchModel.data!.length,
                            separatorBuilder: (context, index) =>
                                dividerInfo(context),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => InfoItemScreen(
                                      id: searchModel.data![index].id!,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
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
                                                    AppCubit.get(context).isDark
                                                        ? Colors.grey
                                                        : Colors.blue[900],
                                                maxRadius: 50,
                                                backgroundImage: NetworkImage(
                                                    searchModel
                                                        .data![index].image!)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    searchModel
                                                        .data![index].name!,
                                                    style: TextStyle(
                                                        color: AppCubit.get(
                                                                    context)
                                                                .isDark
                                                            ? Colors.white
                                                            : Colors.blue[900],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    searchModel.data![index]
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
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                searchModel.data![index].price != searchModel.data![index].pricePro? Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child: Text(
                                                    '${searchModel.data![index].price} \$',
                                                    style: TextStyle(
                                                        decoration: TextDecoration.lineThrough,
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        color:
                                                        Colors.red),
                                                  ),
                                                ):Container(),
                                                SizedBox(height: 5,),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(8.0),
                                                  child: Text(
                                                    '${searchModel.data![index].pricePro} \$',
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Not found any product',
                              style: TextStyle(
                                fontSize: 30,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.grey
                                      : Colors.blue[900]?.withOpacity(0.2)),
                            ),
                          ),
          );
        },
      ),
    );
  }
}
