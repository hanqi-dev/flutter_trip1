


import 'dart:async';
import 'package:flutter_trip1/model/travel_model.dart';
import 'package:dio/dio.dart';

const String travelUrl ='https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
//旅拍页面接口数据
class TravelDao{

  static Future<TravelModel> fetch({String groupChannelCode='RX-OMF',int pageIndex=1,int pageSize=10})async{
    Dio dio = Dio();
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    Map <String,dynamic>queryParam = {
      "districtId": -1,
      "groupChannelCode": groupChannelCode,
      "type": null,
      "lat": -180,
      "lon": -180,
      "locatedDistrictId": 0,
      "pagePara": {
        "pageIndex": pageIndex,
        "pageSize": pageSize,
        "sortType": 9,
        "sortDirection": 0
      },
      "imageCutType": 1,
      "head": {'cid': "09031014111431397988"},
      "contentType": "json"
    };
    var response = await dio.post(travelUrl,queryParameters: queryParam);
    if(response.statusCode==200){
      //中文乱码的问题
      // Utf8Decoder utf8decoder = Utf8Decoder();
      // var result = json.decode(utf8decoder.convert(response.bodyBytes));
      var result = response.data;

      return TravelModel.fromJson(result);

    }else{
      throw Exception('搜索tabs');
    }
  }

}