import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
//拦截处理的域名
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String? url; //url statusBarColor title 空安全也能运行出效果
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool backForbid;

  const WebView(
      {super.key,
      required this.url,
      required this.statusBarColor,
      required this.title,
      required this.hideAppBar,
      this.backForbid = false});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  // final webviewReference = FlutterWebviewPlugin();
  // late StreamSubscription<String> _onUrlChanged;

  // late StreamSubscription<WebViewStateChanged>
  //     _onStateChanged; //!!!!!!!!!!!!!!!null不是WebViewStateChanged回调参数int类型的子集怎麼解决

  // late StreamSubscription<WebViewHttpError> _onHttpError;
  // bool exiting = false;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   webviewReference.close();
  //   _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});
  //   _onStateChanged = webviewReference.onStateChanged.listen((state) {
  //     switch (state.type) {
  //       case WebViewState.startLoad:
  //         if (_isToMain(state.url) && !exiting) {
  //           if (widget.backForbid) {
  //             webviewReference.launch(widget.url ?? 'null');
  //             //state.navigationType = 1;
  //           } else {
  //             Navigator.pop(context);
  //             exiting = true;
  //             //state.navigationType = 1;
  //           }
  //         }

  //         break;
  //       default:
  //         break;
  //     }
  //   });
  //   _onHttpError =
  //       webviewReference.onHttpError.listen((WebViewHttpError error) {
  //     // ignore: avoid_print
  //     print(error);
  //   });
  // }

  // _isToMain(String url) {
  //   bool contain = false;
  //   for (final value in CATCH_URLS) {
  //     if (url.endsWith(value)) {
  //       //url?.endsWith(value) ?? false
  //       contain = true;
  //       break;
  //     }
  //   }
  //   return contain;
  // }
// @override
  // void dispose() {
  //   // TODO: implement dispose
  //   _onStateChanged.cancel();
  //   _onUrlChanged.cancel();
  //   _onHttpError.cancel();
  //   webviewReference.dispose();
  //   super.dispose();
  // }
  WebViewController controller = WebViewController();
  @override
  void initState() {
    
    //跳转html
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          for (final value in CATCH_URLS) {
            if (request.url.endsWith(value)) {
              //拦截处理,回退页面,不知道对不对，安卓返回能直接返回，页面返回不行
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            break;
          }
          // if (request.url.startsWith(CATCH_URLS as Pattern)) {
          //   return NavigationDecision.prevent;
          // }
          return NavigationDecision.navigate;
        },
      ),
    );
    controller.loadRequest(Uri.parse(widget.url.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr =
        widget.statusBarColor ?? 'ffffff'; //widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return Scaffold(
      // body: Column(
      //   children: <Widget>[
      //     _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
      //     // Expanded(
      //     //   //     child: WebviewScaffold(
      //     //   //   url: widget.url ?? 'null', //?? '',
      //     //   //   withZoom: true,
      //     //   //   withLocalStorage: true,
      //     //   //   hidden: true,
      //     //   //   initialChild: Container(
      //     //   //     color: Colors.white,
      //     //   //     child: const Center(
      //     //   //       child: Text('Waiting...'),
      //     //   //     ),
      //     //   //   ),
      //     //   // )
      //     //   child: WebViewWidget(controller: controller),
      //     // ),
      //     Expanded(child: WebViewWidget(controller: controller),)
          
      //   ],
      // ),
      body:WebViewWidget(controller: controller),
    );
  }
//设置跳转页面appbar样式
  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1, //宽度撑满
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Icon(Icons.close, color: backButtonColor, size: 26),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.title ?? 'null',
                    //widget.title ?? '',
                    style: TextStyle(color: backButtonColor, fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
