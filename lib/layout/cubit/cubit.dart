import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/change_fav_model.dart';
import 'package:shop_app/models/create_comment_model.dart';
import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/models/products_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/models/single_product_model.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialStates());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  late ChangeFav changeFav;
  late Map<int, bool> fav = {};
  late Map<int, int> likes = {};
  late ProductsModel productsModel;

  void getProducts() {
    emit(ShopLayoutLoadingGetProductsStates());
    DioHelper.getData(url: 'listProducts', token: token).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      if (productsModel.status!) {
        for (var element in productsModel.data!) {
          fav.addAll({element.id!: element.isLike!});
          likes.addAll({element.id!: element.likesCounts!});
        }
      }

      emit(ShopLayoutSuccessGetProductsStates(productsModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLayoutErrorGetProductsStates());
    });
  }

  late SingleProduct singleProduct;

  void getSingleProduct({required int id}) {
    emit(ShopLayoutLoadingGetSingleProductsStates());
    DioHelper.getData(url: 'singleProductById/$id', token: token).then((value) {
      singleProduct = SingleProduct.fromJson(value.data);

      emit(ShopLayoutSuccessGetSingleProductsStates(singleProduct));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLayoutErrorGetSingleProductsStates());
    });
  }

  void changeFavorites(int id) {
    emit(ShopLayoutSuccessChangeFav());
    DioHelper.getData(url: 'likeProductById/$id', token: token).then((value) {
      changeFav = ChangeFav.fromJson(value.data);
      print(value.data);
      if (changeFav.msg == 'Like done') {
        fav[id] = true;
      } else if (changeFav.msg == 'dislike done') {
        fav[id] = false;
      }

      emit(ShopLayoutSuccessChangeFav());
    }).catchError((error) {
      print(error.toString());
      emit(ShopLayoutErrorChangeFav());
    });
  }

  late CreateComment createComment;

  void createCommentById({required int id, required String comment}) {
    DioHelper.postData(
            url: 'createCommentById',
            data: {"product_id": id, "comment": comment},
            token: token)
        .then((value) {
      createComment = CreateComment.fromJson(value.data);
      emit(ShopLayoutSuccessCreateComment());
      listCommentById(id);
    }).catchError((error) {
      print(error);
      emit(ShopLayoutErrorCreateComment());
    });
  }

  late ListComments listComment;

  void listCommentById(int id) {
    emit(ShopLayoutLoadingShowListComment());
    DioHelper.getData(url: 'listCommentsById/$id', token: token).then((value) {
      listComment = ListComments.fromJson(value.data);
      emit(ShopLayoutSuccessShowListComment(listComment));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLayoutErrorShowListComment());
    });
  }

  late SearchModel searchByCategoryModel;

  void searchByCategoryProduct({String? category}) {
    emit(ShopLayoutLoadingSearchByCategoryStates());
    DioHelper.postData(url: 'searchProduct', token: token, data: {
      'category': category,
    }).then((value) {
      searchByCategoryModel = SearchModel.fromJson(value.data);
      emit(ShopLayoutSuccessSearchByCategoryStates(searchByCategoryModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLayoutErrorSearchByCategoryStates());
    });
  }

  late LogoutModel logoutModel;

  void logout() {
    DioHelper.getData(url: 'logout', token: token).then((value) {
      logoutModel = LogoutModel.fromJson(value.data);
      emit(ShopLayoutSuccessLogoutStates(logoutModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLayoutErrorLogoutStates());
    });
  }
}
