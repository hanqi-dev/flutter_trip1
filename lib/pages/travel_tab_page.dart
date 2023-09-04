// /// 旅拍tab页面
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip1/dao/travel_tab_dao.dart';
import 'package:flutter_trip1/model/travel_model.dart';
import 'dart:math';
import 'package:flutter_trip1/pages/travel_detail_page.dart';
import 'package:flutter_trip1/widget/loading_container.dart';

const PAGE_SIZE = 20;
const INFOS = [
  {
    'imageUrl':
        'https://cools.qctt.cn/1641375161550.jpeg?imageMogr2/size-limit/1024k!',
    'title': '造车还是做供应商？索尼再发概念车型，加速电动汽车商业化进程',
    'author': '林冰',
    'authorUrl': 'http://cools.qctt.cn/b3f686d8c2bdebbcd3a5570e7f8bf73f.jpg',
    'local': '北京市',
  },
  {
    'imageUrl': 'http://cools.qctt.cn/FpcNLchhQZf-OOV2pS92vCC-8V-7',
    'title': '可能是被忽略的实力派！试驾东风本田英仕派 ',
    'author': '芝士驾道',
    'authorUrl': 'http://cools.qctt.cn/1634019239604.',
    'local': '北京市',
  },
  {
    'imageUrl': 'http://cools.qctt.cn/1641104641761.jpeg',
    'title': '我们的爱100℃——跨年音乐嘉年华暨博热派狂欢夜沈阳站圆满收官！ ',
    'author': '车汇天下 栏目组真实牛逼啊，哈哈',
    'authorUrl':
        'http://cools.qctt.cn/FvD14jl-Bn0Htpm0kKzodLPSQ0XE?imageView2/1/w/200/h/200',
    'local': '云南市',
  },
  {
    'imageUrl': 'http://cools.qctt.cn/FoMf8oeTgP6JJW9qsoWXMkzGHM6D',
    'title': '试问男人如何拒绝？与25岁“妙龄女子”度过的美好一天 ',
    'author': 'SUV大师',
    'authorUrl': 'http://cools.qctt.cn/1630578492322.jpeg',
    'local': '齐齐哈尔',
  },
  {
    'imageUrl': 'http://cools.qctt.cn/FoHCUiKMAzBI1eNkXm3fL5dERdNp',
    'title': '击中BBA盲区，试驾国产林肯飞行家 ',
    'author': 'SUV大师',
    'authorUrl': 'http://cools.qctt.cn/1630578492322.jpeg',
    'local': '银川市',
  },
];

class TravelTabPage extends StatefulWidget {
  final String travelUrl;
  final String groupChannelCode;

  TravelTabPage(this.travelUrl, this.groupChannelCode);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<Map> travelItems = [];
  int pageIndex = 1;
  bool _isLoading = true;
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    travelItems.addAll(INFOS);
    _getData();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print('触发加载更多: $pageIndex');
          _getData(loadMore: true);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      isLoading: _isLoading,
      child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: travelItems.length > 0
              ? MasonryGridView.count(
                  controller: _scrollController,

                  crossAxisCount: 2,
                  //每行的个数
                  mainAxisSpacing: 5,
                  //上下间距
                  crossAxisSpacing: 5,
                  //左右间距
                  itemCount: travelItems.length,
                  itemBuilder: (context, index) {
                    final _random = new Random();
                    int next(int min, int max) =>
                        min + _random.nextInt(max - min);
                    var c = next(0, INFOS.length);
                    Map info = INFOS[c];
                    return _TravelItem(info, index);
                  },
                )
              : Center(
                  child: Text('${widget.groupChannelCode} 数据正在加载中'),
                )),
    );
  }
// 缓存页面
  @override
  // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => throw UnimplementedError();
  bool get wantKeepAlive => true;
//数据过滤
  _filterItems(List<TravelItem> list) {
    if (list == null) {
      return [];
    }
    List<TravelItem> filterIttems = [];
    list.forEach((element) {
      if (element.article != null) {
        filterIttems.add(element);
      }
    });
    return filterIttems;
  }
// 下拉刷新
  Future<Null> _handleRefresh({loadMore = false}) async {
    _getData();
    return null;
  }
// 获取数据
  _getData({loadMore = false}) {
    if (loadMore == true) {
      pageIndex = pageIndex + 1;
    } else {
      pageIndex = 1;
    }
    TravelDao.fetch(
            pageIndex: pageIndex,
            pageSize: PAGE_SIZE,
            groupChannelCode: widget.groupChannelCode)
        .then((TravelModel model) {
      print(model);
      setState(() {
        _isLoading = false;

        // List<TravelItem> items = _filterItems(model.travelItems);
        // if (items.length > 0) {
        //   // travelItems.addAll(items);
        // } else {
        //   // travelItems = items;
        // }
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _isLoading = false;
        if (loadMore == true) {
          travelItems.addAll(INFOS);
        } else {
          travelItems.reversed;
        }
      });
    });
  }
}

class _TravelItem extends StatelessWidget {
  final Map item;
  final index;

  _TravelItem(this.item, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('跳转详情页');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TravelDetailPage(item);
        }));
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemImage(item),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              _infoText(item)
            ],
          ),
        ),
      ),
    );
  }

  _itemImage(Map info) {
    return Stack(
      children: [
        // Image.network(info['imageUrl']),
        FadeInImage.assetNetwork(
            placeholder: "images/loadingImage.gif", image: info['imageUrl']),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Text(
                      info['local'],
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  // _itemImage1(Map info){
  //   return FadeInImage.assetNetwork(placeholder: "assets/images/dm_no_image750.png", image: image);
  // }
  _infoText(Map info) {
    return Container(
      padding: EdgeInsets.only(left: 5, bottom: 10, top: 5, right: 5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipOval(
            child: Image.network(
              info['authorUrl'],
              height: 24,
              width: 24,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 80),
              child: Text(
                info['author'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          Expanded(child: Container()),
          Icon(
            Icons.thumb_up,
            size: 14,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Text(
              '56730',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
