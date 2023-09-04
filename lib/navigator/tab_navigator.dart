import 'package:flutter/material.dart';
import 'package:flutter_trip1/pages/my_page.dart';
import 'package:flutter_trip1/pages/travel_page.dart';

import '../pages/home_page.dart';
import '../pages/search_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );
   // 底部导航item
  BottomNavigationBarItem _bottomItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: label,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children:  <Widget>[
          HomePage(),
          SearchPage(hideLeft: true,),//给初值
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.home,
            //       color: _defaultColor,
            //     ),
            //     activeIcon: Icon(
            //       Icons.home,
            //       color: _activeColor,
            //     ),
            //     label: '首页',
            //     backgroundColor:  _currentIndex!=0?_defaultColor:_activeColor
            //     ),
                
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.search,
            //       color: _defaultColor,
            //     ),
            //     activeIcon: Icon(
            //       Icons.search,
            //       color: _activeColor,
            //     ),
            //     label: '搜索',
            //      backgroundColor:  _currentIndex!=1?_defaultColor:_activeColor
            //     ),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.camera_alt,
            //       color: _defaultColor,
            //     ),
            //     activeIcon: Icon(
            //       Icons.camera_alt,
            //       color: _activeColor,
            //     ),
            //     label: '旅拍',
            //      backgroundColor:  _currentIndex!=2?_defaultColor:_activeColor
            //     ),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       Icons.account_circle,
            //       color: _defaultColor,
            //     ),
            //     activeIcon: Icon(
            //       Icons.account_circle,
            //       color: _activeColor,
            //     ),
            //     label: '我的',
            //      backgroundColor:  _currentIndex!=3?_defaultColor:_activeColor
                
            //     ),

          _bottomItem(Icons.home, '首页', 0),
          _bottomItem(Icons.search, '搜索', 1),
          _bottomItem(Icons.camera_alt, '旅拍', 2),
          _bottomItem(Icons.account_circle, '我的', 3),
          ]),
    );
  }
}
