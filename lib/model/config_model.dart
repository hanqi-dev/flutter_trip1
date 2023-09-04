class ConfigModel {
  final String searchUrl;

  ConfigModel({required this.searchUrl});
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(searchUrl: json['searchUrl']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['searchUrl'] = searchUrl;
    return data;
  }
}
