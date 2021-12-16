import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/filters.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'constants.dart';

Widget defaultTextField({
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
      decoration: InputDecoration(
        hintText: hint,
        label: Text(
          label,
          style:
              TextStyle(color: Colors.blue[900], fontWeight: FontWeight.w600),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.blue[900],
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(border!),
        ),
      ),
    );

Widget info({required String key, required value}) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(key, style: TextStyle(color: Colors.blue[900])),
          SizedBox(
            width: 30,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                value,
                overflow: TextOverflow.visible,
                style: TextStyle(color: Colors.blue[900]),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
          ),
        ],
      ),
    );

Widget commentI({required String key, required String value}) => Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Text(key),
          maxRadius: 20,
          backgroundColor: Colors.blue[900],
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(value),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black.withOpacity(0.09)),
        )
      ],
    ));

Widget dividerInfo() => Divider(
      color: Colors.blue[900]?.withOpacity(0.5),
      thickness: 1,
      indent: 30,
      endIndent: 30,
    );

void commentInfo(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => Container(
            color: Colors.blue[300]?.withOpacity(0.2),
            child: SizedBox(
              width: double.infinity,
              height: 500,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: defaultTextField(
                        suffixIcon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () {
                              commentController.clear();
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            icon: Icon(Icons.send, color: Colors.blue[900]),
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
                      itemCount: comment.length,
                      itemBuilder: (context, index) => commentI(
                          key: comment[index]['id'],
                          value: comment[index]['comment']),
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
                            separatorBuilder: (context, index) => dividerInfo(),
                            itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InfoItemScreen(
                                            userName: 'omar alhakeem',
                                            category: 'Canned',
                                            price: 2000,
                                            quantity: 25,
                                            userEmail:
                                                'barddddddddddddaa@gmail.com',
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
