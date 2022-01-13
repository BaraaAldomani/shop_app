import 'package:shop_app/models/create_comment_model.dart';
import 'package:shop_app/models/delete_produce_model.dart';
import 'package:shop_app/models/edit_item_model.dart';
import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/models/profile_model.dart';
import 'package:shop_app/models/single_product_model.dart';

abstract class ProfileStates {}

class ProfileInitialStates extends ProfileStates {}

class ProfileGetUserInfoSuccessStates extends ProfileStates {
  final ProfileModel profileModel;

  ProfileGetUserInfoSuccessStates(this.profileModel);
}

class ProfileGetUserInfoLoadingStates extends ProfileStates {}

class ProfileGetUserInfoErrorStates extends ProfileStates {}

class ProfileLoadingGetSingleProductsStates extends ProfileStates {}

class ProfileErrorGetSingleProductsStates extends ProfileStates {}

class ProfileSuccessGetSingleProductsStates extends ProfileStates {
  final SingleProduct singleProduct;

  ProfileSuccessGetSingleProductsStates(this.singleProduct);
}

class ProfileErrorDeleteProductStates extends ProfileStates {}

class ProfileLoadingDeleteProductStates extends ProfileStates {}

class ProfileSuccessDeleteProductStates extends ProfileStates {
  final DeleteProductModel deleteProductModel;

  ProfileSuccessDeleteProductStates(this.deleteProductModel);
}

class EditItemLoadingStates extends ProfileStates {}

class EditItemErrorStates extends ProfileStates {}

class EditItemSuccessStates extends ProfileStates {
  final EditItemModel editItemModel;

  EditItemSuccessStates(this.editItemModel);
}

class ProfileSuccessCreateComment extends ProfileStates {
  final CreateComment createComment;

  ProfileSuccessCreateComment(this.createComment);
}

class ProfileLoadingCreateComment extends ProfileStates {}

class ProfileErrorCreateComment extends ProfileStates {}

class ProfileLoadingShowListComment extends ProfileStates {}

class ProfileSuccessShowListComment extends ProfileStates {
  final ListComments listComments;

  ProfileSuccessShowListComment(this.listComments);
}

class ProfileErrorShowListComment extends ProfileStates {}
