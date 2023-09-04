import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_trip1/base_view/base_appbar.dart';

class TravelDetailPage extends StatefulWidget {
  final Map info;

  // TravelDetailPage(this.info);

  const TravelDetailPage(this.info,{Key? key}) : super(key: key);

  @override
  _TravelDetailPageState createState() => _TravelDetailPageState();
}

class _TravelDetailPageState extends State<TravelDetailPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar: getAppbarLeadingAndAction(widget.info['title'],IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back)), [IconButton(onPressed: (){}, icon: Icon(Icons.share))],
      ),
      body: Column(children: [
        _buildDetaiHeader(),
      ],),
    );
  }
  _buildDetaiHeader(){
    return Image.network(widget.info['imageUrl']);
  }
}