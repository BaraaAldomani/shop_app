
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/add_item_model.dart';
import 'package:shop_app/modules/add/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

class AddItemCubit extends Cubit<AddItemStates> {
  AddItemCubit() : super(AddItemInitialStates());

  static AddItemCubit get(context) => BlocProvider.of(context);
  late AddItemModel addItemModel;

  void addItem(
      {required dynamic image,
      required String name,
      required String category,
      required String quantity,
      required String exp,
      required String price,
      required String dis1,
      required String dis2,
      required String dis3,
      required String period1,
      required String period2,
      required String period3}) async{
    emit(AddItemLoadingStates());

String imageName = image.path.split('/').last;
var formData = FormData.fromMap( {
  'image':await  MultipartFile.fromFile(image.path,filename: imageName ),
  'name': name,
  'category': category,
  'quantity': quantity,
  'expiretion_date': exp,
  'price': price,
  'discount_1': dis1,
  'discount_2': dis2,
  'discount_3': dis3,
  'discount_period_1': period1,
  'discount_period_2': period2,
  'discount_period_3': period3,
});

    DioHelper.postData(
            url: 'createProduct',

            token: token,
            data: formData
    )
        .then((value) {
      addItemModel = AddItemModel.fromJson(value.data);

      emit(AddItemSuccessStates(addItemModel));
    }).catchError((error) {
      emit(AddItemErrorStates());
      print(error.toString());
    });
  }
}
