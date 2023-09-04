import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip1/dao/search_dao.dart';
import 'package:flutter_trip1/model/search_model.dart';
import 'package:flutter_trip1/pages/speak_page.dart';
import 'package:flutter_trip1/until/navigator_until.dart';
import 'package:flutter_trip1/widget/seach_bar.dart';
import 'package:flutter_trip1/widget/webview.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
const url =
    'https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=aotucomplete&contentType=json&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String? keyWord;
  final String? hint;
  const SearchPage(
      {super.key,
      required this.hideLeft,
      this.searchUrl = url,
      this.keyWord,
      this.hint});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;
  String keyWord = '携程';
  String showText = ''; //测试
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    try {
      SearchModel model = await SearchDao.fetch(url, '携程');
      setState(() {
        searchModel = model; //解决late初始化的问题
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar,
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: _itemCount, //数据结构设计 searchModel!.data[position];
                  itemBuilder: (BuildContext context, int position) {
                    return _item(position); //position从0开始遍历
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget get _appBar {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            height: 80,
            decoration: const BoxDecoration(color: Colors.white),
            child: SearchBar(
              hideLeft: widget.hideLeft,
              defaultText: widget.keyWord ?? '',
              hint: widget.hint ?? '',
              leftButtonClick: () {
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
              enabled: true,
              rightButtonClick: _rightButtonClick,
              inputBoxClick: _inputBoxClick,
              speakClick: _speakClick,
            ),
          ),
        )
      ],
    );
  }

  void _onTextChange(String value) {
    keyWord = value;
    if (value.isEmpty) {
      setState(() {
        searchModel = {} as SearchModel;
      });
    }
    String url = widget.searchUrl +
        value; //String url = widget.searchUrl??' + value;这俩值没链接上 将url设置为非空
    SearchDao.fetch(url, value).then((SearchModel model) {
      if (model.keyWord == keyWord) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError(((onError) {
      print(onError);
    }));
  }

  void _rightButtonClick() {}

  void _inputBoxClick() {}

  void _speakClick() {
    NavigatorUtil.push(context, SpeakPage());
  }

  Widget? _item(int position) {
    if (searchModel == null) return null;
    SearchItem item = searchModel!.data[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                    url: item.url,
                    statusBarColor: '',
                    title: '详情',
                    hideAppBar: false)));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(1),
              child: Image(
                height: 26,
                width: 26,
                image: AssetImage(_typeName(item.type)),
              ),
            ),
            Column(
              children: [
                Container(
                  width: 300,
                  child:
                      // Text(
                      //     '${item.word} ${item.districtname ?? ''} ${item.zonename ?? ''}'),
                      _title(item),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 5),
                  child:
                      //Text('${item.price ?? ''} ${item.type ?? ''}'),
                      _subtitle(item),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _typeName(String? type) {
    if (type == null) {
      return 'assets/images/type_travelgroup.png';
    }
    String path = 'travelgroup';
    for (final val in TYPES) {
      if (type.contains(val)) {
        {
          path = val;
          break;
        }
      }
      return 'assets/images/type_$path.png';
    }
  }

  _title(SearchItem item) {
    if (item == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel!.keyWord));
    spans.add(TextSpan(
        text: ' ' + (item.districtname ?? '') + ' ' + (item.zonename ?? ''),
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  _subtitle(SearchItem item) {
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: item.price ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
      TextSpan(
          text: ' ' + (item.star ?? ''),
          style: const TextStyle(fontSize: 16, color: Colors.grey)),
    ]));
  }

  _keywordTextSpans(String? word, String keyWord) {
    List<TextSpan> spans = [];
    if (word == null || word.isEmpty) return spans;
    List<String> arr = word.split(keyWord);
    TextStyle normalStyle =
        const TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keyWordStyle =
        const TextStyle(fontSize: 16, color: Colors.orange);
    //'wordwoc'.split('w')->[,ord,oc]使用w分隔
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyWord, style: keyWordStyle));
      }
      String val = arr[i];
      if (val != null && val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
  //resolve null check--searchModel
  int get _itemCount {
    if (searchModel == null)
      return 0;
    else
      return searchModel!.data.length;
  }
}
