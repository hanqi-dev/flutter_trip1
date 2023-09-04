// 字段 | 类型 | 备注
// | -------- | -------- | -------- |
// icon | String	| NonNull
// moreUrl | String	|	NonNull
// bigCard1 | Object	|	NonNull
// bigCard2 | Object	|	NonNull
// smallCard1 | Object	|	NonNull
// smallCard2 | Object	|	NonNull
// smallCard3 | Object	|	NonNull
// smallCard4 | Object	|	NonNull
//活动入口模型
import 'package:flutter_trip1/model/common_model.dart';

class SalesBoxModel {
  final String icon;
  final String moreUrl;
  final CommonModel bigCard1;
  final CommonModel bigCard2;
  final CommonModel smallCard1;
  final CommonModel smallCard2;
  final CommonModel smallCard3;
  final CommonModel smallCard4;

  SalesBoxModel(
      {required this.icon,
      required this.moreUrl,
      required this.bigCard1,
      required this.bigCard2,
      required this.smallCard1,
      required this.smallCard2,
      required this.smallCard3,
      required this.smallCard4});
  //CommonModel(this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar);
  factory SalesBoxModel.fromJson(Map<String, dynamic> json) {
    return SalesBoxModel(
      icon: json['icon'],
      moreUrl: json['moreUrl'],
      bigCard1: CommonModel.fromJson(json['bigCard1']),
      bigCard2: CommonModel.fromJson(json['bigCard2']),
      smallCard1: CommonModel.fromJson(json['smallCard1']),
      smallCard2: CommonModel.fromJson(json['smallCard2']),
      smallCard3: CommonModel.fromJson(json['smallCard3']),
      smallCard4: CommonModel.fromJson(json['smallCard4']),
      
    );
  }
  // Map<dynamic, dynamic> toJson() {
  //   return {
  //     icon:icon,
  //     moreUrl:moreUrl,
  //     bigCard1:bigCard1,
  //     bigCard2:bigCard2,
  //     smallCard1:smallCard1,
  //     smallCard2:smallCard2,
  //     smallCard3:smallCard3,
  //     smallCard4:smallCard4,
  //   };
  // }
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['moreUrl'] = moreUrl;
    data['bigCard1'] = bigCard1;
    data['bigCard2'] = bigCard2;
    data['smallCard1'] = smallCard1;
    data['smallCard2'] = smallCard2;
    data['smallCard3'] = smallCard3;
    data['smallCard4'] = smallCard4;
    return data;
  }
}
