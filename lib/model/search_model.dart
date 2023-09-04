//
class SearchModel {
  String keyWord;
  final List<SearchItem> data;

  SearchModel({required this.data,required this.keyWord});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    var datajson = json['data'] as List;
    List<SearchItem> data =
        datajson.map((e) => SearchItem.fromJson(e)).toList();
    return SearchModel(data: data,keyWord: '');
  }
}

class SearchItem {
 late String? word; //string？允许变量为空
 late String? type;
 late String? price;
 late String? star;
 late String? zonename;
 late String? districtname;
 late final String url;

  SearchItem(
      {this.word,
      this.type,
      this.price,
      this.star,
      this.zonename,
      this.districtname,
      required this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      word: json['word'],
      type: json['type'],
      price: json['price'],
      star: json['star'],
      zonename: json['zonename'],
      districtname: json['districtName'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['type'] = type;
    data['url'] = url;
    data['price'] = price;
    data['star'] = star;
    data['zonename'] = zonename;
    data['districtName'] = districtname;
    return data;
  }
}
