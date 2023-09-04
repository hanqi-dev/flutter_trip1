

import 'dart:async';
import 'package:flutter_trip1/model/travel_tab_model.dart';
import 'package:dio/dio.dart';

const String travelTypeUrl ='http://www.devio.org/io/flutter_app/json/travel_page.json';
//旅拍类别结果
class TravelTabDao{

  static Future<TravelTabModel> fetch()async{
    Dio dio = Dio();
    var response = await dio.get(travelTypeUrl);
    if(response.statusCode==200){
      //中文乱码的问题
      // Utf8Decoder utf8decoder = Utf8Decoder();
      // var result = json.decode(utf8decoder.convert(response.bodyBytes));
      var result = response.data;

      return TravelTabModel.fromJson(result);

    }else{
      throw Exception('搜索tabs');
    }
  }

}