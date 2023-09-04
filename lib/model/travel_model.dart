//旅拍页模型
class TravelModel {
  late int? totalCount;
  late List<TravelItem> travelItems;

  TravelModel({required this.totalCount,  required this.travelItems});

  TravelModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['resultList'] != null) {
      travelItems = [];
      json['resultList'].forEach((v) {
        travelItems.add(new TravelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.travelItems != null) {
      data['resultList'] = this.travelItems.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class TravelItem {
  late int type;
  late Article article;

  TravelItem({required this.type, required this.article});

  TravelItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    article =
    (json['article'] != null ? new Article.fromJson(json['article']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.article != null) {
      data['article'] = this.article.toJson();
    }
    return data;
  }
}
class Article {
  late int articleId;
  late int productType;
  late int sourceType;
  late String articleTitle;
  late Author author;
  late List<Images> images;
  late bool hasVideo;
  late int readCount;
  late int likeCount;
  late int commentCount;
  late List<Urls> urls;
  late List<Pois> pois;
  late String publishTime;
  late String publishTimeDisplay;
  late String shootTime;
  late String shootTimeDisplay;
  late int level;
  late String distanceText;
  late bool isLike;
  late int imageCounts;
  late bool isCollected;
  late int collectCount;

  Article(
      {required this.articleId,
        required this.productType,
        required this.sourceType,
        required this.articleTitle,
        required this.author,
        required this.images,
        required this.hasVideo,
        required this.readCount,
        required this.likeCount,
        required this.commentCount,
        required this.urls,
        required this.pois,
        required this.publishTime,
        required this.publishTimeDisplay,
        required this.shootTime,
        required this.shootTimeDisplay,
        required this.level,
        required this.distanceText,
        required this.isLike,
        required this.imageCounts,
        required this.isCollected,
        required this.collectCount});

  Article.fromJson(Map<String, dynamic> json) {
    articleId = json['articleId'];
    productType = json['productType'];
    sourceType = json['sourceType'];
    articleTitle = json['articleTitle'];
    author =
    (json['author'] != null ? new Author.fromJson(json['author']) : null)!;
    if (json['images'] != null) {
      images =[];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    readCount = json['readCount'];
    likeCount = json['likeCount'];
    commentCount = json['commentCount'];
    if (json['urls'] != null) {
      urls = [];
      json['urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
    if (json['pois'] != null) {
      pois =[];
      json['pois'].forEach((v) {
        pois.add(new Pois.fromJson(v));
      });
    }
    publishTime = json['publishTime'];
    publishTimeDisplay = json['publishTimeDisplay'];
    shootTime = json['shootTime'];
    shootTimeDisplay = json['shootTimeDisplay'];
    level = json['level'];
    distanceText = json['distanceText'];
    isLike = json['isLike'];
    imageCounts = json['imageCounts'];
    isCollected = json['isCollected'];
    collectCount = json['collectCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articleId'] = this.articleId;
    data['productType'] = this.productType;
    data['sourceType'] = this.sourceType;
    data['articleTitle'] = this.articleTitle;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['hasVideo'] = this.hasVideo;
    data['readCount'] = this.readCount;
    data['likeCount'] = this.likeCount;
    data['commentCount'] = this.commentCount;
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }

    data['publishTime'] = this.publishTime;
    data['publishTimeDisplay'] = this.publishTimeDisplay;
    data['shootTime'] = this.shootTime;
    data['shootTimeDisplay'] = this.shootTimeDisplay;
    data['level'] = this.level;
    data['distanceText'] = this.distanceText;
    data['isLike'] = this.isLike;
    data['imageCounts'] = this.imageCounts;
    data['isCollected'] = this.isCollected;
    data['collectCount'] = this.collectCount;
    return data;
  }
}
class Author {
  late int authorId;
  late String nickName;
  late String clientAuth;
  late String jumpUrl;
  late CoverImage coverImage;
  late int identityType;
  late String tag;

  Author(
      {required this.authorId,
        required this.nickName,
        required this.clientAuth,
        required this.jumpUrl,
        required this.coverImage,
        required this.identityType,
        required this.tag});

  Author.fromJson(Map<String, dynamic> json) {
    authorId = json['authorId'];
    nickName = json['nickName'];
    clientAuth = json['clientAuth'];
    jumpUrl = json['jumpUrl'];
    coverImage = (json['coverImage'] != null
        ? new CoverImage.fromJson(json['coverImage'])
        : null)!;
    identityType = json['identityType'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorId'] = this.authorId;
    data['nickName'] = this.nickName;
    data['clientAuth'] = this.clientAuth;
    data['jumpUrl'] = this.jumpUrl;
    if (this.coverImage != null) {
      data['coverImage'] = this.coverImage.toJson();
    }
    data['identityType'] = this.identityType;
    data['tag'] = this.tag;
    return data;
  }
}

class CoverImage{
  late String dynamicUrl;
  late String originalUrl;

  CoverImage({required this.dynamicUrl, required this.originalUrl});
  CoverImage.fromJson(Map<String,dynamic>json){
    dynamicUrl=json['dynamicUrl'];
    originalUrl = json['originalUrl'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dynamicUrl'] = this.dynamicUrl;
    data['originalUrl'] = this.originalUrl;
    return data;
  }

}

class Images {
  late int imageId;
  late String dynamicUrl;
  late String originalUrl;
  late double width;
  late double height;
  late int mediaType;
  late bool isWaterMarked;

  Images(
      {required this.imageId,
        required this.dynamicUrl,
        required this.originalUrl,
        required this.width,
        required this.height,
        required this.mediaType,
        required this.isWaterMarked});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    dynamicUrl = json['dynamicUrl'];
    originalUrl = json['originalUrl'];
    width = json['width'];
    height = json['height'];
    mediaType = json['mediaType'];
    isWaterMarked = json['isWaterMarked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageId'] = this.imageId;
    data['dynamicUrl'] = this.dynamicUrl;
    data['originalUrl'] = this.originalUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['mediaType'] = this.mediaType;
    data['isWaterMarked'] = this.isWaterMarked;
    return data;
  }
}
class Urls {
  late String version;
  late String appUrl;
  late String h5Url;
  late String wxUrl;

  Urls({required this.version, required this.appUrl, required this.h5Url, required this.wxUrl});

  Urls.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    appUrl = json['appUrl'];
    h5Url = json['h5Url'];
    wxUrl = json['wxUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['appUrl'] = this.appUrl;
    data['h5Url'] = this.h5Url;
    data['wxUrl'] = this.wxUrl;
    return data;
  }
}

class Pois {
  late int poiType;
  late int poiId;
  late String poiName;
  late int districtId;
  late String districtName;
  late String districtENName;
  late PoiExt poiExt;
  late int source;
  late int isMain;

  Pois(
      {required this.poiType,
        required this.poiId,
        required this.poiName,
        required this.districtId,
        required this.districtName,
        required this.districtENName,
        required this.poiExt,
        required this.source,
        required this.isMain});

  Pois.fromJson(Map<String, dynamic> json) {
    poiType = json['poiType'];
    poiId = json['poiId'];
    poiName = json['poiName'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    districtENName = json['districtENName'];
    poiExt =
    (json['poiExt'] != null ? new PoiExt.fromJson(json['poiExt']) : null)!;
    source = json['source'];
    isMain = json['isMain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poiType'] = this.poiType;
    data['poiId'] = this.poiId;
    data['poiName'] = this.poiName;
    data['districtId'] = this.districtId;
    data['districtName'] = this.districtName;
    data['districtENName'] = this.districtENName;
    if (this.poiExt != null) {
      data['poiExt'] = this.poiExt.toJson();
    }
    data['source'] = this.source;
    data['isMain'] = this.isMain;
    return data;
  }
}

class PoiExt {
  late String h5Url;
  late String appUrl;

  PoiExt({required this.h5Url, required this.appUrl});

  PoiExt.fromJson(Map<String, dynamic> json) {
    h5Url = json['h5Url'];
    appUrl = json['appUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['h5Url'] = this.h5Url;
    data['appUrl'] = this.appUrl;
    return data;
  }
}