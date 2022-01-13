import 'package:shop_app/models/search_model.dart';

abstract class SearchStates {}

class SearchInitialStates extends SearchStates {}
class SearchSuccessStates extends SearchStates {
  final SearchModel searchModel;

  SearchSuccessStates(this.searchModel);
}
class SearchLoadingStates extends SearchStates {}
class SearchErrorStates extends SearchStates {}
