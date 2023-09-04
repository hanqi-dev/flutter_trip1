// config | Object	| NonNull
// bannerList | Array	|	NonNull
// localNavList | Array	|	NonNull
// gridNav | Object	|	NonNull
// subNavList | Array	|	NonNull
// salesBox | Object	|	NonNull
import 'package:flutter_trip1/model/common_model.dart';
import 'package:flutter_trip1/model/config_model.dart';
import 'package:flutter_trip1/model/grid_nav_model.dart';
import 'package:flutter_trip1/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;
  HomeModel(
      {required this.config,
      required this.bannerList,
      required this.localNavList,
      required this.subNavList,
      required this.gridNav,
      required this.salesBox});
  // factory HomeModel.fromJson(Map<String, dynamic> json) {
  //   return HomeModel(
  //     config: ConfigModel.fromJson(json['config']),
  //     bannerList: //CommonModel.fromJson(json['bannerList']),
  //     localNavList: // CommonModel.fromJson(json['localNavList']),
  //     gridNav: GridNavModel.fromJson(json['gridNav']),
  //     salesBox: SalesBoxModel.fromJson(json['salesBox']),
  //   );
  // }
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();
    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();
    return HomeModel(
        config: ConfigModel.fromJson(json['config']),
        bannerList: bannerList,
        localNavList: localNavList,
        subNavList: subNavList,
        gridNav: GridNavModel.fromJson(json['gridNav']),
        salesBox: SalesBoxModel.fromJson(json['salesBox']));
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['config'] = config;
    data['bannerList'] = bannerList;
    data['localNavList'] = localNavList;
    data['subNavList'] = subNavList;
    data['gridNav'] = gridNav;
    data['salesBox'] = salesBox;
    return data;
  }
}
