import 'package:shop_app/models/list_comment_model.dart';
import 'package:shop_app/models/logout_model.dart';
import 'package:shop_app/models/products_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/models/single_product_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialStates extends ShopLayoutStates {}

class ShopLayoutChangeThemeModeStates extends ShopLayoutStates {}

class ShopLayoutChangeAppLanguageStates extends ShopLayoutStates {}

class ShopLayoutChangeFavItemStates extends ShopLayoutStates {}

class ShopLayoutSuccessGetProductsStates extends ShopLayoutStates {
  final ProductsModel productsModel;

  ShopLayoutSuccessGetProductsStates(this.productsModel);
}

class ShopLayoutLoadingGetProductsStates extends ShopLayoutStates {}

class ShopLayoutErrorGetProductsStates extends ShopLayoutStates {}

class ShopLayoutSuccessChangeFav extends ShopLayoutStates {}

class ShopLayoutErrorChangeFav extends ShopLayoutStates {}

class ShopLayoutSuccessCreateComment extends ShopLayoutStates {}

class ShopLayoutErrorCreateComment extends ShopLayoutStates {}

class ShopLayoutSuccessShowListComment extends ShopLayoutStates {
  final ListComments listComments;

  ShopLayoutSuccessShowListComment(this.listComments);
}

class ShopLayoutLoadingShowListComment extends ShopLayoutStates {}

class ShopLayoutErrorShowListComment extends ShopLayoutStates {}

class ShopLayoutSuccessGetSingleProductsStates extends ShopLayoutStates {
  final SingleProduct singleProduct;

  ShopLayoutSuccessGetSingleProductsStates(this.singleProduct);
}

class ShopLayoutLoadingGetSingleProductsStates extends ShopLayoutStates {}

class ShopLayoutErrorGetSingleProductsStates extends ShopLayoutStates {}
class ShopLayoutSuccessSearchByCategoryStates extends ShopLayoutStates {
  final SearchModel searchByCategoryModel;
  ShopLayoutSuccessSearchByCategoryStates(this.searchByCategoryModel);
}
class ShopLayoutErrorSearchByCategoryStates extends ShopLayoutStates {}
class ShopLayoutLoadingSearchByCategoryStates extends ShopLayoutStates {}

class ShopLayoutSuccessLogoutStates extends ShopLayoutStates {
  final LogoutModel logoutModel;
  ShopLayoutSuccessLogoutStates(this.logoutModel);

}
class ShopLayoutErrorLogoutStates extends ShopLayoutStates {}

