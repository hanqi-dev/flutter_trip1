import 'package:flutter/material.dart';
import 'package:flutter_trip1/dao/travel_dao.dart';
import 'package:flutter_trip1/model/travel_tab_model.dart';
import 'package:flutter_trip1/pages/travel_tab_page.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin{
  late TabController _controller;
  List<TravelTabs>  tabs =[];
  late TravelTabModel travelTabModel;
  _getData(){
    TravelTabDao.fetch().then((TravelTabModel tabModel){
      print(tabModel);
      _controller = TabController(length: tabModel.tabs!.length, vsync: this);

      setState(() {
        tabs = tabModel.tabs!;
        travelTabModel = tabModel;
      });
    }).catchError((e){
      print(e);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    _getData();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child:tabs.length>0?TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator:UnderlineTabIndicator(
                  borderSide: BorderSide(color: Color(0xff2fcfbb),width: 3),
                  insets: EdgeInsets.fromLTRB(0, 0, 0, 10),
                ) ,
                tabs: tabs.map<Tab>((TravelTabs model){
                      return Tab(text: model.labelName,);
                }).toList()
            ):Container() ,
          ),
          Expanded(flex: 1,child:  TabBarView(
              controller: _controller,
              children: tabs.map((TravelTabs model){
                return TravelTabPage(travelTabModel.url!,model.groupChannelCode!);
              }).toList()
          ),)
         ,
        ],
      )
    );
  }
}

