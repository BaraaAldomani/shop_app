import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeTheme() {
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeThemeStates());
    });

  }

  bool isEnglish = true;

  void changeLanguage(value) {
    isEnglish = !value;
    emit(AppChangeLanguageStates());
  }

  bool isFav = false;

  void putLikeItem(bool isLike) {
    isFav = !isLike;
    emit(AppChangeFavStates());
  }

  //pick Image
  final ImagePicker _imagePicker = ImagePicker();
  late File image1;
  bool photoIsTake = false;

  Future getImage(ImageSource source) async {
    final image = await _imagePicker.pickImage(source: source);
    if (image == null) return;
    final imageTemporary = File(image.path);
    image1 = imageTemporary;
    photoIsTake = true;
    emit(AppUserGetImageStates());
  }


}
