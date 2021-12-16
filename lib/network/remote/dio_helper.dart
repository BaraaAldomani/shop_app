import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'http://192.168.1.101:8000/api/',
          receiveDataWhenStatusError: true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {'Authorization': token};
    return await dio.post(url, data: data);
  }

  Future<Response<dynamic>> getData(
      {required String url,
      required Map<String, dynamic> data,
      String? token}) async {
    dio.options.headers = {'Authorization': token};
    return await dio.get(url);
  }
}
