import 'package:flutter/material.dart';
import 'package:flutter_trip1/model/common_model.dart';
import 'package:flutter_trip1/widget/webview.dart';
//活动卡片入口
class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({super.key, required this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null)
      return null;
    else {
      List<Widget> items = [];
      subNavList.forEach((model) {
        items.add(_item(context, model));
      });
      //计算出第一行显示的数量
      int separate = (subNavList.length / 2 + 0.5).toInt();
      return Container(
        height: double.infinity, //指定宽高为无限大，column可以滚动
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: items.sublist(0, separate),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: items.sublist(separate, subNavList.length),
                ),
              )
            ],
          ),
        ),
      );
      // return Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: items,
      // );
    }
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WebView(
                          url: model.url,
                          statusBarColor: model.statusBarColor ?? '',
                          title: model.title!,
                          hideAppBar: model.hideAppBar,
                        )));
          },
          child: Column(
            children: <Widget>[
              Image.network(
                //'https://www.devio.org/io/flutter_app/img/ln_ticket.png',
                model.icon ?? '', //flutter空安全的解决办法
                width: 18,
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  //"攻略·景点",
                  model.title ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
