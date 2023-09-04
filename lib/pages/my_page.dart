import 'package:flutter/material.dart';
import 'package:flutter_trip1/widget/webview.dart';
//我的页面
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebView(url: 'https://m.ctrip.com/webapp/myctrip/',statusBarColor: '4c5bca',title: '',hideAppBar: true,backForbid: true,)
      
    );
  }
}
