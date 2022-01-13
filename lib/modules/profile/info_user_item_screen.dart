import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/delete_produce_model.dart';
import 'package:shop_app/models/single_product_model.dart';
import 'package:shop_app/modules/profile/cubit/cubit.dart';
import 'package:shop_app/modules/profile/cubit/states.dart';
import 'package:shop_app/modules/profile/edit_item_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class InfoUserItemScreen extends StatefulWidget {
 final int id;

  InfoUserItemScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<InfoUserItemScreen> createState() => _InfoUserItemScreenState();
}

var commentController = TextEditingController();
late SingleProduct userProduct;
late DeleteProductModel deleteProductModel;

class _InfoUserItemScreenState extends State<InfoUserItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppCubit.get(context).isEnglish? TextDirection.ltr:TextDirection.rtl,
      child: BlocProvider(
        create: (context) => ProfileCubit()..getSingleProduct(id: widget.id),
        child:
            BlocConsumer<ProfileCubit, ProfileStates>(listener: (context, state) {
          if (state is ProfileSuccessGetSingleProductsStates) {
            if (state.singleProduct.status || !state.singleProduct.status) {
              userProduct = ProfileCubit.get(context).singleProduct;
            }
          }
          if (state is ProfileSuccessDeleteProductStates) {
            Fluttertoast.showToast(
                    msg: 'Delete success', backgroundColor: Colors.green)
                .then((value) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            });
          }
        }, builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return Scaffold(
            body: state is ProfileLoadingGetSingleProductsStates
                ? Center(child: CircularProgressIndicator())
                : Container(
                    color: AppCubit.get(context).isDark
                        ? Colors.grey[700]
                        : Colors.blue[300]?.withOpacity(0.2),
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: AppCubit.get(context).isDark
                                  ? Colors.grey[700]
                                  : Colors.blue[100],
                              maxRadius: 3,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.blue[900],
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => ProfileScreen()));
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
                                  color: AppCubit.get(context).isDark
                                      ? Colors.white38
                                      : Colors.blue[900]?.withOpacity(0.5),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  userProduct.data.name,
                                  style: TextStyle(
                                    color: AppCubit.get(context).isDark
                                        ? Colors.black.withOpacity(0.6)
                                        : Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            background: Container(
                              color: AppCubit.get(context).isDark
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
                                imageUrl: userProduct.data.image,
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
                                backgroundColor: Colors.orange,
                                child: IconButton(

                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditItem(
                                              id: userProduct.data.id,
                                              period1:
                                                  '${userProduct.data.discountPeriod_1}',
                                              period2:
                                                  '${userProduct.data.discountPeriod_2}',
                                              period3:
                                                  '${userProduct.data.discountPeriod_3}',
                                              dis2:
                                                  '${userProduct.data.discount_2}',
                                              dis3:
                                                  '${userProduct.data.discount_3}',
                                              dis1:
                                                  '${userProduct.data.discount_1}',
                                              category: userProduct.data.category,
                                              exp: userProduct.data.expiretionDate,
                                              image: userProduct.data.image,
                                              name: userProduct.data.name,
                                              price: '${userProduct.data.price}',
                                              quantity: '${userProduct.data.id}',
                                            )));
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.red[900],
                                child: IconButton(

                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor:
                                            AppCubit.get(context).isDark
                                                ? Colors.grey[900]
                                                : Colors.white,
                                        title: Text(
                                          'Delete',
                                          style: TextStyle(
                                            color: Colors.red[900],
                                            fontSize: 30,
                                          ),
                                        ),
                                        content: Text(
                                          'Are you sure?',
                                          style: TextStyle(
                                              color: AppCubit.get(context).isDark
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
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
                                              cubit.deleteProduct(id: widget.id);
                                            },
                                            child: state
                                                    is ProfileLoadingDeleteProductStates
                                                ? CircularProgressIndicator()
                                                : Text(
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
                            ),
                          ],
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.remove_red_eye,
                                  color: AppCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.blue[900],
                                ),
                                title: Text(
                                  '${userProduct.data.views}',
                                  style: TextStyle(
                                      color: AppCubit.get(context).isDark
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
                                            color: AppCubit.get(context).isDark
                                                ? Colors.white
                                                : Colors.blue[900]),
                                      ),
                                      SizedBox(
                                        height: 250,
                                        width: 250,
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
                                                    '${AppCubit.get(context).getText('exp')!}:',
                                                value: userProduct
                                                    .data.expiretionDate),
                                            info(
                                                context: context,
                                                key:
                                                    '${AppCubit.get(context).getText('category')!}:',
                                                value: AppCubit.get(context)
                                                    .getText(userProduct
                                                        .data.category)!),
                                            info(
                                                context: context,
                                                key:
                                                    '${AppCubit.get(context).getText('quantity')!}:',
                                                value:
                                                    '${userProduct.data.quantity}'),
                                            info(
                                                context: context,
                                                key:
                                                    '${AppCubit.get(context).getText('price')!}:',
                                                value:
                                                    '${userProduct.data.pricePro} \$'),
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
                                  color: AppCubit.get(context).isDark
                                      ? Colors.white
                                      : Colors.blue[900],
                                ),
                                title: Text(
                                  userProduct.data.sellers.name,
                                  style: TextStyle(
                                      color: AppCubit.get(context).isDark
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
                                            '${AppCubit.get(context).getText('phone_number')!}:',
                                            style: TextStyle(
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? Colors.white
                                                        : Colors.blue[900]),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              userProduct.data.sellers.phoneNo,
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                  color:
                                                      AppCubit.get(context).isDark
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
                                            '${AppCubit.get(context).getText('email_address')!}:',
                                            style: TextStyle(
                                                color:
                                                    AppCubit.get(context).isDark
                                                        ? Colors.white
                                                        : Colors.blue[900]),
                                          ),
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              userProduct.data.sellers.email,
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                  color:
                                                      AppCubit.get(context).isDark
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
