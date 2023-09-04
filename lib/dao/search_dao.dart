import 'package:flutter_trip1/model/search_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
//var url = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class SearchDao {
  static Future<SearchModel> fetch(String url, String value) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //只有当当前输入的内容和服务端返回的内容一样才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyWord = value;
      return model;
      
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
