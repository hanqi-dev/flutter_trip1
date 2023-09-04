import 'package:flutter/material.dart';
import 'package:flutter_trip1/model/common_model.dart';
import 'package:flutter_trip1/model/grid_nav_model.dart';
import 'package:flutter_trip1/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel? gridNavModel;//解决空安全问题
  const GridNav({super.key, required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    // if (gridNavModel == null) return items;
    // if (gridNavModel != null) {
    //   items.add(_gridNavItem(context, gridNavModel.hotel, true));
    // }
    // if (gridNavModel != null) {
    //   items.add(_gridNavItem(context, gridNavModel.flight, true));
    // }
    // if (gridNavModel != null) {
    //   items.add(_gridNavItem(context, gridNavModel.travel, true));
    // }

    
    // ignore: unnecessary_null_comparison
    if (gridNavModel == null) return items;
    items.add(_gridNavItem(context, gridNavModel!.hotel, true));
    items.add(_gridNavItem(context, gridNavModel!.flight, true));
    items.add(_gridNavItem(context, gridNavModel!.travel, true));
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget> expandItems = [];
    for (var item in items) {
      expandItems.add(
        Expanded(flex: 1, child: item),
      );
    }
    String gridnavitemStartcolor = gridNavItem.startColor;
    String gridnavitemEndcolor = gridNavItem.endColor;

    Color startColor = Color(int.parse('0xff$gridnavitemStartcolor'));
    Color endColor = Color(int.parse('0xff$gridnavitemEndcolor'));
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.network(
              model.icon!,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
                margin: const EdgeInsets.only(top: 11),
                child: Text(
                  model.title??'',
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ))
          ],
        ),
        model);
  }

  _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          left: borderSide,
          bottom: first ? borderSide : BorderSide.none,
        )),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item.title??'',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            item),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: model.url,
                      statusBarColor: model.statusBarColor.toString(),
                      title: model.title.toString(),
                      hideAppBar: model.hideAppBar,
                    )));
      },
      child: widget,
    );
  }
}
