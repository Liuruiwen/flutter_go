/**
 * Created by Amuser
 * Date:2019/8/22.
 * Desc:导航数据
 */

import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class NavigationBean extends Object {

  @JsonKey(name: 'data')
  List<NavigationData> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  NavigationBean(this.data,this.errorCode,this.errorMsg,);

  factory NavigationBean.fromJson(Map<String, dynamic> srcJson) => _$NavigationBeanFromJson(srcJson);

}


@JsonSerializable()
class NavigationData extends Object {

  @JsonKey(name: 'articles')
  List<NavigationArticles> articles;

  @JsonKey(name: 'cid')
  int cid;

  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'selectType')
  int selectType;

  NavigationData(this.articles,this.cid,this.name,this.selectType);

  factory NavigationData.fromJson(Map<String, dynamic> srcJson) => _$NavigationDataFromJson(srcJson);

}


@JsonSerializable()
class  NavigationArticles extends Object{

  @JsonKey(name: 'apkLink')
  String apkLink;

  @JsonKey(name: 'author')
  String author;

  @JsonKey(name: 'chapterId')
  int chapterId;

  @JsonKey(name: 'chapterName')
  String chapterName;

  @JsonKey(name: 'collect')
  bool collect;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'envelopePic')
  String envelopePic;

  @JsonKey(name: 'fresh')
  bool fresh;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'niceDate')
  String niceDate;

  @JsonKey(name: 'origin')
  String origin;

  @JsonKey(name: 'prefix')
  String prefix;

  @JsonKey(name: 'projectLink')
  String projectLink;

  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'superChapterId')
  int superChapterId;

  @JsonKey(name: 'superChapterName')
  String superChapterName;

  @JsonKey(name: 'tags')
  List<dynamic> tags;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'visible')
  int visible;

  @JsonKey(name: 'zan')
  int zan;

  NavigationArticles(this.apkLink,this.author,this.chapterId,this.chapterName,this.collect,this.courseId,this.desc,this.envelopePic,this.fresh,this.id,this.link,this.niceDate,this.origin,this.prefix,this.projectLink,this.publishTime,this.superChapterId,this.superChapterName,this.tags,this.title,this.type,this.userId,this.visible,this.zan,);

  factory NavigationArticles.fromJson(Map<String, dynamic> srcJson) => _$NavigationArticlesFromJson(srcJson);

}


NavigationBean _$NavigationBeanFromJson(Map<String, dynamic> json) {
  return NavigationBean(
      (json['data'] as List)
          ?.map((e) =>
      e == null ? null : NavigationData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$NavigationBeanToJson(NavigationBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

NavigationData _$NavigationDataFromJson(Map<String, dynamic> json) {
  return NavigationData(
      (json['articles'] as List)
          ?.map((e) =>
      e == null ? null : NavigationArticles.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['cid'] as int,
      json['name'] as String,
      json['selectType'] as int
  );
}

Map<String, dynamic> _$DataToJson(NavigationData instance) => <String, dynamic>{
  'articles': instance.articles,
  'cid': instance.cid,
  'name': instance.name
};

NavigationArticles _$NavigationArticlesFromJson(Map<String, dynamic> json) {
  return NavigationArticles(
      json['apkLink'] as String,
      json['author'] as String,
      json['chapterId'] as int,
      json['chapterName'] as String,
      json['collect'] as bool,
      json['courseId'] as int,
      json['desc'] as String,
      json['envelopePic'] as String,
      json['fresh'] as bool,
      json['id'] as int,
      json['link'] as String,
      json['niceDate'] as String,
      json['origin'] as String,
      json['prefix'] as String,
      json['projectLink'] as String,
      json['publishTime'] as int,
      json['superChapterId'] as int,
      json['superChapterName'] as String,
      json['tags'] as List,
      json['title'] as String,
      json['type'] as int,
      json['userId'] as int,
      json['visible'] as int,
      json['zan'] as int);
}

Map<String, dynamic> _$ArticlesToJson(NavigationArticles instance) => <String, dynamic>{
  'apkLink': instance.apkLink,
  'author': instance.author,
  'chapterId': instance.chapterId,
  'chapterName': instance.chapterName,
  'collect': instance.collect,
  'courseId': instance.courseId,
  'desc': instance.desc,
  'envelopePic': instance.envelopePic,
  'fresh': instance.fresh,
  'id': instance.id,
  'link': instance.link,
  'niceDate': instance.niceDate,
  'origin': instance.origin,
  'prefix': instance.prefix,
  'projectLink': instance.projectLink,
  'publishTime': instance.publishTime,
  'superChapterId': instance.superChapterId,
  'superChapterName': instance.superChapterName,
  'tags': instance.tags,
  'title': instance.title,
  'type': instance.type,
  'userId': instance.userId,
  'visible': instance.visible,
  'zan': instance.zan
};
