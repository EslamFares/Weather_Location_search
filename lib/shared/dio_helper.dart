import 'package:dio/dio.dart';
//https://api.openweathermap.org/data/2.5/weather?lat=30.0626&lon=31.2497&appid=2db8334a16a6a509e314680779471b9b
//https://api.openweathermap.org/data/2.5/weather?q=cairo&appid=2db8334a16a6a509e314680779471b9b


//http://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
//base url : http://newsapi.org/
//method(url) : v2/top-headlines?
//queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
class DioHelper {
  static Dio dio= Dio();
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.openweathermap.org/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }
}