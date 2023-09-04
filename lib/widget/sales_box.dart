import 'package:flutter/material.dart';
import 'package:flutter_trip1/model/common_model.dart';
import 'package:flutter_trip1/model/sales_box_model.dart';
import 'package:flutter_trip1/widget/webview.dart';

//底部卡片入口
class SalesBox extends StatelessWidget {
  final SalesBoxModel? salesBox;//解决空安全问题

  const SalesBox({super.key, required this.salesBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(7),
      //   child: _items(context),
      // ),
      child: _items(context),
    );
  }

  _items(BuildContext context) {
    if (salesBox == null) return null;

    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBox!.bigCard1, salesBox!.bigCard2, true, false));
    items.add(_doubleItem(
        context, salesBox!.smallCard1, salesBox!.smallCard2, false, false));
    items.add(_doubleItem(
        context, salesBox!.smallCard3, salesBox!.smallCard4, false, false));

    return Column(
      children: [
        Container(
          height: 44,
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                salesBox!.icon,
                height: 15,
                fit: BoxFit.fill,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
                margin: const EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xffff4e63),
                          Color(0xffff6cc9),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebView(
                                  url: salesBox!.moreUrl,
                                  statusBarColor: '',
                                  title: '更多活动',
                                  hideAppBar: false,
                                )));
                  },
                  child: const Text(
                    '获取更多福利 >',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.sublist(0, 1),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        )
      ],
    );
  }

  _doubleItem(BuildContext context, CommonModel leftCard, CommonModel rightCard,
      bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item(context, leftCard, big, true, last),
        _item(context, rightCard, big, false, last)
      ],
    );
  }

  Widget _item(
      BuildContext context, CommonModel model, bool big, bool left, bool last) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    return GestureDetector(
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
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                right: left ? borderSide : BorderSide.none,
                bottom: last ? BorderSide.none : borderSide),
          ),
          child: Image.network(
            //'https://www.devio.org/io/flutter_app/img/ln_ticket.png',
            model.icon ?? '', //flutter空安全的解决办法 ？？没有值则为‘ ’
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 2 - 10,
            height: big ? 129 : 80, 
          ),
        ));
  }
}
