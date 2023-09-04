// hotel | Object	| NonNull
// flight | Object	|	NonNull
// travel | Object	|	NonNull

// 首页网格卡片模型
import 'package:flutter_trip1/model/common_model.dart';

class GridNavModel {
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;

  GridNavModel({
    required this.hotel,
    required this.flight,
    required this.travel,
  });
  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
      hotel: GridNavItem.fromJson(json['hotel']),
      flight: GridNavItem.fromJson(json['flight']),
      travel: GridNavItem.fromJson(json['travel']),
    );//cant be null so not !=null?
  }
  // Map<dynamic, dynamic> toJson() {
  //   return {
  //     hotel:hotel,
  //     flight:flight,
  //     travel:travel,
  //   };
  // }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hotel'] = hotel;
    data['flight'] = flight;
    data['travel'] = travel;
    return data;
  }
}

class GridNavItem {
  final String startColor;
  final String endColor;

  
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

//GridNavItem(this.startColor, this.endColor, this.item1, this.item2, this.item3, this.item4);
  GridNavItem(
      {required this.startColor,
      required this.endColor,
      required this.mainItem,
      required this.item1,
      required this.item2,
      required this.item3,
      required this.item4});
  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem:CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
    );
  }
  //   Map<dynamic, dynamic> toJson() {
  //   return {
  //     startColor: startColor,
  //     endColor: endColor,
  //     item1: item1,
  //     item2:item2,
  //     item3:item3,
  //     item4:item4,
  //   };
  // }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startColor'] = startColor;
    data['endColor'] = endColor;
    data['item1'] = item1;
    data['item2'] = item2;
    data['item3'] = item3;
    data['item4'] = item4;
    return data;
  }
}
