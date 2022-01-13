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

  void changeTheme({bool? isShared}) {
    if(isShared != null){
      isDark = isShared;
    }else {
      isDark = !isDark;
    }
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeThemeStates());
    });
  }

  bool isEnglish = true;

  Map<String,String> ar = {
  //login

  'login': 'تسجيل الدخول',
  'email_address': 'البريد الإلكتروني',
  'password': 'كلمة المرور'  ,
  'register': 'التسجيل',
  'not_have_account': 'لا تملك حساب؟',
  //register
  'name':'الاسم',
  'conf_password':'تأكيد كلمة المرور',
  'phone_number':'رقم الهاتف',
    //shopLayout
    'appBar_title':'المتجر',
    'type_comment':'اكتب تعليق...',
    'search_something':'البحث...',
    //settings
    'settings':'الإعدادات',
    'profile':'الملف الشخصي',
    'logout':'تسجيل الخروج',
    'dark':'داكن',
    'light':'فاتح',
    'arabic':'عربي',
    'english':'انجليزي',
    //profile
    'not_have_product':'لا تملك أي منتجات لعرضها',
    //addItem
    'gallery': 'الألبوم',
    'camera':'كاميرا',
    'canned':'معلبات',
    'fruits':'فواكه',
    'vegetable':'خضار',
    'Name must be not empty':'الاسم يجب أن لا يكون فارغاً',
    'add_item':'إضافة منتج',
    'category':'التصنيف',
    'quantity':'الكمية',
    'exp':'الصلاحية',
    'price':'السعر',
    'photo':'الصورة',
    'pick_image':'اختر صورة',
    'dis1':'الخصم الأول',
    'dis2':'الخصم الثاني',
    'dis3':'الخصم الثالث',
    'last_period':'آخر',
    'days':'يوم',
    'upload':'رفع المنتج',
    'ok':'موافق',
    //editItem
    'appBar_edit_title':'تعديل المنتج',
    'edit':'تعديل',
    'item_info':'معلومات المنتج',
    'delete':'حذف',
    'are_you_sure':'هل أنت متأكد',
    'no':'لا',
    'yes':'نعم',
    //search
    'search_by_name':'البحث من خلال الاسم',
    'search_by_date':'البحث من خلال التاريخ',
    'search':'البحث',
    'not_found_any_product':'لا يوجد أي منتجات',
    "no_product_to_show":'لا يوجد أي منتج للعرض',
    "create_one_now": 'أضف منتج الآن'
    };
  Map <String,String>en={
  "create_one_now": 'Create one Now',
  "no_product_to_show":'No Products to show',
    'login': 'Login',
    'email_address': 'Email Address',
    'password': 'Password'  ,
    'register': 'Register',
    'not_have_account': "didn't have an account?",
    //register
    'name':'Name',
    'conf_password':'confirm password',
    'phone_number':'Phone number',
    //shopLayout
    'appBar_title':'Shop',
    'type_comment':'Type comment...',
    'search_something':'search...',
    //settings
    'settings':'Settings',
    'profile':'Profile',
    'logout':'Logout',
    'dark':'Dark',
    'light':'Light',
    'arabic':'Arabic',
    'english':'English',
    //profile
    'not_have_product':"You don't have any product",
    //addItem
    'gallery': 'Gallery',
    'camera':'Camera',
    'canned':'Canned',
    'fruits':'Fruits',
    'vegetable':'Vegetable',
    'Name must be not empty':'Name must be not empty',
    'add_item':'Add Item',
    'category':'Category',
    'quantity':'Quantity',
    'exp':'Expiration',
    'price':'Price',
    'photo':'Photo',
    'pick_image':'Pick Image',
    'dis1':'discount 1',
    'dis2':'discount 2',
    'dis3':'discount 3',
    'last_period':'Last',
    'days':'day',
    'upload':'Upload',
    'ok':'Ok',
    //editItem
    'appBar_edit_title':'Edit Item',
    'edit':'Edit',
    'item_info':'Item Info:',
    'delete':'Delete',
    'are_you_sure':'Are you sure?',
    'no':'No',
    'yes':'Yes',
    'search_by_name':'search by name',
    'search_by_date':'search by date',
    'search':'Search',
    'not_found_any_product':'Not found any product'
  };

  void changeLanguage(bool lang) {
    isEnglish = !lang;
    emit(AppChangeLanguageStates());
  }
  String? getText(String key){
   return isEnglish? en[key]: ar[key];
  }


}
