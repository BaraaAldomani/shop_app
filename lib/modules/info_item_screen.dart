import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/single_product_model.dart';
import 'package:shop_app/modules/comment/comment_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class InfoItemScreen extends StatefulWidget {
  int id;

  InfoItemScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<InfoItemScreen> createState() => _InfoItemScreenState();
}

var commentController = TextEditingController();
late SingleProduct product;

class _InfoItemScreenState extends State<InfoItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppCubit
          .get(context)
          .isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: BlocProvider(
        create: (context) =>
        ShopLayoutCubit()
          ..getSingleProduct(id: widget.id),
        child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
            listener: (context, state) {
              if (state is ShopLayoutSuccessGetSingleProductsStates) {
                if (state.singleProduct.status || !state.singleProduct.status) {
                  product = ShopLayoutCubit
                      .get(context)
                      .singleProduct;
                }
              }
            }, builder: (context, state) {
          ShopLayoutCubit cubit = ShopLayoutCubit.get(context);
          return Scaffold(
            body: state is ShopLayoutLoadingGetSingleProductsStates
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Container(
              color: AppCubit
                  .get(context)
                  .isDark
                  ? Colors.grey[700]
                  : Colors.blue.withOpacity(0.2),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: AppCubit
                            .get(context)
                            .isDark
                            ? Colors.grey[700]
                            : Colors.blue[100],
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppCubit
                                .get(context)
                                .isDark
                                ? Colors.white
                                : Colors.blue[900],
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => ShopLayout()),
                                    (route) => false);
                          },
                        ),
                      ),
                    ),
                    snap: false,
                    pinned: false,
                    floating: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                        decoration: BoxDecoration(
                            color: AppCubit
                                .get(context)
                                .isDark
                                ? Colors.white38
                                : Colors.blue[900]?.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            product.data.name,
                            style: TextStyle(
                              color: AppCubit
                                  .get(context)
                                  .isDark
                                  ? Colors.black.withOpacity(0.6)
                                  : Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      background: Container(
                        color: AppCubit
                            .get(context)
                            .isDark
                            ? Colors.grey
                            : Colors.blue[900],
                        child: CachedNetworkImage(
                          progressIndicatorBuilder:
                              (context, imageUrl, download) {
                            if (download.progress != null) {
                              return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    value: 5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ));
                            }
                            return Center(
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ));
                          },
                          imageUrl: product.data.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    expandedHeight: 300,
                    backgroundColor: Colors.blue[900],
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: AppCubit
                              .get(context)
                              .isDark
                              ? Colors.grey[700]
                              : Colors.blue[100],
                          child: IconButton(
                            onPressed: () {
                              cubit.changeFavorites(product.data.id);
                              favorites![product.data.id] =
                              !favorites![product.data.id];
                            },
                            icon: Icon(
                              favorites![product.data.id]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: AppCubit
                                  .get(context)
                                  .isDark
                                  ? Colors.white
                                  : Colors.blue[900],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: AppCubit
                              .get(context)
                              .isDark
                              ? Colors.grey[700]
                              : Colors.blue[100],
                          child: IconButton(
                            icon: Icon(
                              Icons.mode_comment_outlined,
                              color: AppCubit
                                  .get(context)
                                  .isDark
                                  ? Colors.white
                                  : Colors.blue[900],
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CommentScreen(id:product.data.id)));
                            },
                          ),
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
                            color: AppCubit
                                .get(context)
                                .isDark
                                ? Colors.white
                                : Colors.blue[900],
                          ),
                          title: Text(
                            '${product.data.views}',
                            style: TextStyle(
                                color: AppCubit
                                    .get(context)
                                    .isDark
                                    ? Colors.white
                                    : Colors.blue[900],
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
                                  AppCubit.get(context)
                                      .getText('item_info')!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppCubit
                                          .get(context)
                                          .isDark
                                          ? Colors.white
                                          : Colors.blue[900]),
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
                                      info(
                                          context: context,
                                          key:
                                          '${AppCubit.get(context).getText(
                                              'exp')!} :',
                                          value:
                                          product.data.expiretionDate),
                                      info(
                                          context: context,
                                          key:
                                          '${AppCubit.get(context).getText(
                                              'category')!}:',
                                          value: AppCubit.get(context)
                                              .getText(
                                              product.data.category)!),
                                      info(
                                          context: context,
                                          key:
                                          '${AppCubit.get(context).getText(
                                              'quantity')!}:',
                                          value:
                                          '${product.data.quantity}'),
                                      info(
                                          context: context,
                                          key:
                                          '${AppCubit.get(context).getText(
                                              'price')!}:',
                                          value:
                                          '${product.data.pricePro} \$'),
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
                            color: AppCubit
                                .get(context)
                                .isDark
                                ? Colors.white
                                : Colors.blue[900],
                          ),
                          title: Text(
                            product.data.sellers.name,
                            style: TextStyle(
                                color: AppCubit
                                    .get(context)
                                    .isDark
                                    ? Colors.white
                                    : Colors.blue[900],
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
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${AppCubit.get(context).getText(
                                          'phone_number')!}:',
                                      style: TextStyle(
                                          color:
                                          AppCubit
                                              .get(context)
                                              .isDark
                                              ? Colors.white
                                              : Colors.blue[900]),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        product.data.sellers.phoneNo,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            color:
                                            AppCubit
                                                .get(context)
                                                .isDark
                                                ? Colors.black
                                                : Colors.blue[900]),
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
                                      '${AppCubit.get(context).getText(
                                          'email_address')!}:',
                                      style: TextStyle(
                                          color:
                                          AppCubit
                                              .get(context)
                                              .isDark
                                              ? Colors.white
                                              : Colors.blue[900]),
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        product.data.sellers.email,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                            color:
                                            AppCubit
                                                .get(context)
                                                .isDark
                                                ? Colors.black
                                                : Colors.blue[900]),
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
      ),
    );
  }
}
