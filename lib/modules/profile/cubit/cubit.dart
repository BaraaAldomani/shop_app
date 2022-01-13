import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/create_comment_model.dart';
import 'package:shop_app/models/delete_produce_model.dart';
import 'package:shop_app/models/edit_item_model.dart';
import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/single_product_model.dart';
import 'package:shop_app/modules/profile/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialStates());

  static ProfileCubit get(context) => BlocProvider.of(context);

  late ProfileModel profileModel;
  void getUserInfo() {
    emit(ProfileGetUserInfoLoadingStates()) ;
    DioHelper.getData(url: 'profile', token: token).then((value) {

      profileModel = ProfileModel.fromJson(value.data);

      emit(ProfileGetUserInfoSuccessStates(profileModel));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileGetUserInfoErrorStates());
    });
  }

  late SingleProduct singleProduct;

  void getSingleProduct({required int id}) {
    emit(ProfileLoadingGetSingleProductsStates());
    DioHelper.getData(url: 'singleProductById/$id', token: token).then((value) {
      singleProduct = SingleProduct.fromJson(value.data);

      emit(ProfileSuccessGetSingleProductsStates(singleProduct));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorGetSingleProductsStates());
    });
  }
  late DeleteProductModel deleteProductModel;
  void deleteProduct({required int id }){
    emit(ProfileLoadingDeleteProductStates());
    DioHelper.getData(url: 'deleteProductById/$id' , token: token).then((value){
      deleteProductModel = DeleteProductModel.fromJson(value.data);
      emit(ProfileSuccessDeleteProductStates(deleteProductModel));
    }).catchError((error){
      print(error);
      emit(ProfileErrorDeleteProductStates());
    });
  }

  late EditItemModel editItemModel;
  void editItem(
      {
        required int id,
        required dynamic image,
        required String name,
        required String category,
        required String quantity,
        required String price,
        required String dis1,
        required String dis2,
        required String dis3,
        required String period1,
        required String period2,
        required String period3

      }) async{
    emit(EditItemLoadingStates());

    String imageName = image.path.split('/').last;
    var formData = FormData.fromMap( {
      'image':await  MultipartFile.fromFile(image.path,filename: imageName ),
      'name': name,
      'id':id,
      'category': category,
      'quantity': quantity,
      'price': price,
      'discount_1': dis1,
      'discount_2': dis2,
      'discount_3': dis3,
      'discount_period_1': period1,
      'discount_period_2': period2,
      'discount_period_3': period3,
    });

    DioHelper.postData(
        url: 'editProductById',
        token: token,
        data: formData
    )
        .then((value) {
      editItemModel = EditItemModel.fromJson(value.data);
      emit(EditItemSuccessStates(editItemModel));
    }).catchError((error) {
      emit(EditItemErrorStates());
      print(error.toString());
    });
  }

  late CreateComment createComment;

  void createCommentById({required int id, required String comment}) {
    emit(ProfileLoadingCreateComment());
    DioHelper.postData(
        url: 'createCommentById',
        data: {"product_id": id, "comment": comment},
        token: token)
        .then((value) {
      createComment = CreateComment.fromJson(value.data);
      emit(ProfileSuccessCreateComment(createComment));
      listCommentById(id);
    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorCreateComment());
    });
  }

  late ListComments listComment;

  void listCommentById(int id) {
    emit(ProfileLoadingShowListComment());
    DioHelper.getData(url: 'listCommentsById/$id', token: token).then((value) {
      listComment = ListComments.fromJson(value.data);
      emit(ProfileSuccessShowListComment(listComment));
    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorShowListComment());
    });
  }


}
