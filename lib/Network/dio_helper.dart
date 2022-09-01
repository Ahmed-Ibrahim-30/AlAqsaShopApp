import 'package:dio/dio.dart';
import 'package:shopapp/Components/variableShared.dart';

//https://api.nutritionix.com/
// v1_1/search/mcdonalds
// fields=item_name,brand_name,item_id,nf_calories&appId=6d403fd5&appKey=ba8eb2b717981637150cd2ac78a86051




class DioHelper{
  static late Dio dio;
  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError:true,
        headers: {
          'Content-Type':'application/json'
        }
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String,dynamic> ?query,
    String ?token,
  })async{
    dio.options.headers={
      'lang':responseLanguage,
      'Content-Type':'application/json',
      'Authorization':token??'',
    };



    return await dio.get(url,queryParameters: query??{});
  }

  static Future<Response> postData({
    required String url,
    Map<String ,dynamic>?query,
    required Map<String ,dynamic>data,
    String ?token,
}) async{
    dio.options.headers={
      'lang':responseLanguage,
      'Authorization':token??'',
      'Content-Type':'application/json'
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> putData({
    required String url,
    Map<String ,dynamic>?query,
    required Map<String ,dynamic>data,
    String ?token,
  }) async{
    dio.options.headers={
      'lang':responseLanguage,
      'Authorization':token??'',
      'Content-Type':'application/json'
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }



}