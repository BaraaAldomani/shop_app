import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel searchModel;

  void searchProduct({ String? name ,  String? date}) {
    emit(SearchLoadingStates());
    DioHelper.postData(url: 'searchProduct', token: token , data: {
      'name':name,
      'expiretion_date':date
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates(searchModel));
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }


}
