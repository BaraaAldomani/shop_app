import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/modules/info_item_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';

class CommentScreen extends StatelessWidget {
  final int id;

  CommentScreen({Key? key, required this.id}) : super(key: key);
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late ListComments _listComments;
    return Directionality(

      textDirection: AppCubit.get(context).isEnglish?TextDirection.ltr:TextDirection.rtl,
      child: BlocProvider(
        create: (context) => ShopLayoutCubit()..listCommentById(id),
        child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
          listener: (context, state) {
            if (state is ShopLayoutSuccessShowListComment) {
              _listComments = state.listComments;
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('comment'),
                centerTitle: true,
              ),
              body: state is ShopLayoutLoadingShowListComment
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(

                          child: ListView.separated(
                            separatorBuilder: (context,index)=>dividerInfo(context),
                            itemCount: _listComments.data.length,
                            itemBuilder: (context, index) => commentI(
                                context: context,
                                key: '${index + 1}',
                                value: _listComments.data[index].comment),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultTextField(
                              context: context,
                              controller: _commentController,
                              keyboardType: TextInputType.text,
                              label:
                                  AppCubit.get(context).getText('type_comment')!,
                              prefixIcon: Icons.comment,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  ShopLayoutCubit.get(context).createCommentById(
                                      id: id, comment: _commentController.text);
                                  _commentController.clear();
                                },
                                icon: Icon(Icons.send),
                                color: AppCubit.get(context).isDark
                                    ? Colors.white
                                    : Colors.blue[900],
                              )),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
