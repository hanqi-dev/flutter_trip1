// | -------- | -------- | -------- |
// icon | String	| Nullable
// title | String	|	Nullable
// url | String	|	NonNull
// statusBarColor | String	|	Nullable
// hideAppBar | bool	|	Nullable
class CommonModel {
   String? icon;//string？允许变量为空
   String? title;
   String url;
   String? statusBarColor;
   bool? hideAppBar;

  CommonModel(
      {required this.icon,
      required this.title,
      required this.url,
      required this.statusBarColor,
      required this.hideAppBar});
  //CommonModel(this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar);
  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'] ?? '',
      title: json['title']??'',
      url: json['url'],
      statusBarColor: json['statusBarColor']??'',
      hideAppBar: json['hideAppBar']??false,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['icon'] = icon;
    data['title'] = title;
    data['url'] = url;
    data['statusBarColor'] = statusBarColor;
    data['hideAppBar'] = hideAppBar;
    return data;
  }
}
