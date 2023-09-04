import 'package:flutter/material.dart';
import 'package:flutter_trip1/model/common_model.dart';
import 'package:flutter_trip1/widget/webview.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({super.key, required this.localNavList});

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
    // ignore: unnecessary_null_comparison
    if (localNavList == null) {
      return null;
    } else {
      List<Widget> items = [];
      for (var model in localNavList) {
        items.add(_item(context, model));
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      );
    }
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,//model.statusBarColor is null 改为‘’
                    title: model.title!,
                    hideAppBar: model.hideAppBar,
                    )));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            //'https://www.devio.org/io/flutter_app/img/ln_ticket.png',
            model.icon??'', //flutter空安全的解决办法
            width: 32,
            height: 32,
          ),
          Text(
            //"攻略·景点",
            model.title??'',
            style: const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
