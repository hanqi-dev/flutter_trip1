import 'dart:convert';
import 'dart:ffi';

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_trip1/dao/home_dao.dart';
import 'package:flutter_trip1/model/common_model.dart';
import 'package:flutter_trip1/model/grid_nav_model.dart';
import 'package:flutter_trip1/model/home_model.dart';
import 'package:flutter_trip1/model/sales_box_model.dart';
import 'package:flutter_trip1/pages/search_page.dart';
import 'package:flutter_trip1/pages/speak_page.dart';
import 'package:flutter_trip1/until/navigator_until.dart';
import 'package:flutter_trip1/widget/grid_nav.dart';
import 'package:flutter_trip1/widget/loading_container.dart';
import 'package:flutter_trip1/widget/local_nav.dart';
import 'package:flutter_trip1/widget/sales_box.dart';
import 'package:flutter_trip1/widget/sub_nav.dart';
import 'package:flutter_trip1/widget/webview.dart';

import '../widget/seach_bar.dart';

//首页
//变量的定义：可空 不可空 各自怎麼解决？
const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg',
  ]; //测试用例
  double appBarAlpha = 0;
  var resultString = '';
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
   GridNavModel? gridNavModel; //解决初始化
  SalesBoxModel? salesBoxModel;
  bool _loading = true;
  void initState() {
    _handleRefresh();
    super.initState();
    
  }

//根据滚动计算appBarAlpha值用来设置顶部图片滚动渐变
  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    //print(appBarAlpha);用不了print
  }

  Future<Null> _handleRefresh() async {
    // HomeDao.fetch().then((result) {
    //   setState(() {
    //     resultString = json.encode(result);
    //   });
    // }).catchError((e) {
    //   setState(() {
    //     resultString = e.toString();
    //   });
    // });
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model.config);
        localNavList = model.localNavList;
        subNavList = model.subNavList;
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        _loading = false;
      });
    } catch (e) {
      // setState(() {
      //   resultString = e.toString();
      // });
      // ignore: avoid_print
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: LoadingContainer(
            isLoading: _loading, //刷新
            child: Stack(
              children: <Widget>[
                MediaQuery.removePadding(
                    removeTop: true, //移除顶部padding
                    context: context,
                    child: RefreshIndicator(
                      onRefresh: _handleRefresh,
                      child: NotificationListener(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification &&
                              scrollNotification.depth == 0) {
                            _onScroll(scrollNotification.metrics.pixels);
                          }
                          return true; //right or not?
                        },
                        child: _listview,
                      ),
                    )),

                //往下拉颜色渐变之后在顶部显示的内容
                // Opacity(
                //   opacity: appBarAlpha,
                //   // child: Container(
                //   //   height: 80,
                //   //   decoration: const BoxDecoration(color: Colors.white),
                //   //   child: const Center(
                //   //     child: Padding(
                //   //       padding: EdgeInsets.only(top: 20),
                //   //       child: Text('首页'),
                //   //     ),
                //   //   ),
                //   // ),//最开始设计为显示首页appbar渐变用的方法
                //   child: _appBar//显示的具体widget//如果使用opacity包裹则只会在下拉listview会将搜索框渐变出来
                // )
                SizedBox(
                  child: _appBar,
                ) //用sizedbox对搜索框样式进行包装
              ],
            )));
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  //appbar 渐变遮罩背景
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
            child: SearchBar(
              hideLeft: true,
              defaultText: '网红打卡地 景点 酒店 美食',
              hint: '景点',
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
              enabled: true,
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              rightButtonClick: _rightButtonClick,
              inputBoxClick: _inputBoxClick,
              speakClick: _speakClick,
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0, //>0.2 is 0.5 <0.2 is 0
          decoration: const BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  Widget get _listview {
    return ListView(
      //physics: NeverScrollableScrollPhysics(),//bu zhun gun dong
      children: <Widget>[
        _banner,
        Container(
          //最开始使用的padding包裹
          padding: const EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(subNavList: subNavList),
        ),
        SizedBox(
          //set widget area
          height: 340, //这个widget适合屏幕的高度
          child: SalesBox(salesBox: salesBoxModel),
        ),

        // SizedBox(
        //   height: 342,
        //   child: ListTile(
        //     title: Text('resultString'),
        //   ),
        // )
      ],
    );
  }

  Widget get _banner {
    return SizedBox(
      height: 160,
      child: Swiper(
        itemCount: bannerList.length, //_imageUrls.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  CommonModel model = bannerList[index];
                  return WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,
                    title: model.title,
                    hideAppBar: model.hideAppBar,
                  );
                }),
              );
            },
            child: Image.network(
              bannerList[index].icon ?? '',
              fit: BoxFit.fill,
            ),
          );
        },
        pagination: const SwiperPagination(),
      ),
    );
  }

  void _onTextChange(String value) {}

  void _rightButtonClick() {}
//点击首页输入框跳转到搜索页面
  void _inputBoxClick() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SearchPage(
        hideLeft: false,
        hint: '景点',
      );
    }
    )
    );
  }

  void _speakClick() {
    NavigatorUtil.push(context, SpeakPage());
  }
}
