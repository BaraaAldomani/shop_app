import 'package:shop_app/models/add_item_model.dart';

abstract class AddItemStates{}
class AddItemInitialStates extends AddItemStates{}
class AddItemLoadingStates extends AddItemStates{}
class AddItemErrorStates extends AddItemStates{}
class AddItemSuccessStates extends AddItemStates{
  final AddItemModel addItemModel;
  AddItemSuccessStates(this.addItemModel);
}