import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/modules/filters.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

Widget defaultTextField({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  String? hint,
  String? initialValue,
  IconData? prefixIcon,
  String? Function(String?)? validate,
  Function(String)? onSubmit,
  Function(String)? onChanged,
  Function(String?)? onSaved,
  Function()? onTap,
  Widget? suffixIcon,
  double? border = 5,
  bool enable = true,
  bool readOnly = false,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword,
      initialValue: initialValue,
      onChanged: onChanged,
      onSaved: onSaved,
      onTap: onTap,
      enabled: enable,
      readOnly: readOnly,
      controller: controller,
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      validator: validate,
      autofocus: false,
      style: TextStyle(
          color:
              AppCubit.get(context).isDark ? Colors.white : Colors.blue[900]),
      decoration: InputDecoration(
        hintText: hint,
        label: Text(
          label,
          style: TextStyle(
              color: AppCubit.get(context).isDark
                  ? Colors.white
                  : Colors.blue[900],
              fontWeight: FontWeight.w600),
        ),
        prefixIcon: Icon(prefixIcon,
            color:
                AppCubit.get(context).isDark ? Colors.white : Colors.blue[900]),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border!),
        ),
      ),
    );

Widget info({required String key, required value, context}) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(key,
              style: TextStyle(
                  color: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.blue[900])),
          Spacer(),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                value,
                overflow: TextOverflow.visible,
                style: TextStyle(
                    color: AppCubit.get(context).isDark
                        ? Colors.black
                        : Colors.blue[900]),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
          ),
        ],
      ),
    );

Widget commentI(
        {required String key,
        required String value,
        required BuildContext context}) =>
    Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text(
                key,
                style: TextStyle(color: Colors.white),
              ),
              maxRadius: 20,
              backgroundColor: AppCubit.get(context).isDark
                  ? Colors.black
                  : Colors.blue[900],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(value,style: TextStyle(color: AppCubit.get(context).isDark?Colors.white:Colors.blue[900]), overflow: TextOverflow.ellipsis , maxLines: 50,),
              ),
            )
          ],
        ));

Widget dividerInfo(context) => Divider(
      color: AppCubit.get(context).isDark
          ? Colors.white.withOpacity(0.5)
          : Colors.blue[900]?.withOpacity(0.5),
      thickness: 1,
      indent: 30,
      endIndent: 30,
    );

void commentInfo(context, int index, ListComments list) {
  showModalBottomSheet(
      context: context,
      builder: (_) => Container(
            color: AppCubit.get(context).isDark
                ? Colors.black.withOpacity(0.6)
                : Colors.blue[300]?.withOpacity(0.2),
            child: SizedBox(
              width: double.infinity,
              height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: defaultTextField(
                        context: context,
                        suffixIcon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () {
                              ShopLayoutCubit.get(context).createCommentById(
                                  id: ShopLayoutCubit.get(context)
                                      .productsModel
                                      .data![index]
                                      .id!,
                                  comment: commentController.text);
                              commentController.clear();
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: AppCubit.get(context).isDark
                                  ? Colors.white
                                  : Colors.blue[900],
                            ),
                          ),
                        ),
                        border: 50,
                        prefixIcon: Icons.pending,
                        controller: commentController,
                        label: 'type comment',
                        keyboardType: TextInputType.text),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: list.data.length,
                      itemBuilder: (context, index) => commentI(
                          context: context,
                          key: '${list.data[index].sellerId}',
                          value: '${list.data[index].comment}'),
                    ),
                  ),
                ],
              ),
            ),
          ));
}

void searchInfo(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  color: Colors.blue[300]?.withOpacity(0.2),
                  child: SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemCount: 10,
                            separatorBuilder: (context, index) =>
                                dividerInfo(context),
                            itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InfoItemScreen(
                                            id: 5,
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'orange',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    '20 - 10 - 2040',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue[900],
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Filters(),
                          ],
                        ),
                      );
                    },
                    child: Icon(Icons.filter_alt_outlined),
                  ),
                ),
              ],
            ),
          ));
}
