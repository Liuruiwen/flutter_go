import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_go/module/base/ObjectBean.dart';
/**
 * Created by Amuser
 * Date:2019/8/8.
 * Desc:
 */
@JsonSerializable()
 class NewListDataBean extends ObjectBean{

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
  List<Tags> tags;

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

  NewListDataBean(this.apkLink,this.author,this.chapterId,this.chapterName,this.collect,this.courseId,this.desc,this.envelopePic,this.fresh,this.id,this.link,this.niceDate,this.origin,this.prefix,this.projectLink,this.publishTime,this.superChapterId,this.superChapterName,this.tags,this.title,this.type,this.userId,this.visible,this.zan,);

  factory NewListDataBean.fromJson(Map<String, dynamic> srcJson) => _$NewListDataBeanFromJson(srcJson);

}

NewListDataBean _$NewListDataBeanFromJson(Map<String, dynamic> json) {
  return NewListDataBean(
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
      (json['tags'] as List)
          ?.map((e) =>
      e == null ? null : Tags.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['title'] as String,
      json['type'] as int,
      json['userId'] as int,
      json['visible'] as int,
      json['zan'] as int);
}


@JsonSerializable()
class Tags extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'url')
  String url;

  Tags(this.name,this.url,);

  factory Tags.fromJson(Map<String, dynamic> srcJson) => _$TagsFromJson(srcJson);

}

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(json['name'] as String, json['url'] as String);
}