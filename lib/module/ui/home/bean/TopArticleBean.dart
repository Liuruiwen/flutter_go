import 'package:flutter_go/module/base/ObjectBean.dart';
/**
 * Created by Amuser
 * Date:2019/8/20.
 * Desc:置顶文章
 */
import 'package:json_annotation/json_annotation.dart';

import 'TopArticleDataBean.dart';



@JsonSerializable()
class TopArticleBean extends Object{

  @JsonKey(name: 'data')
  List<TopArticleDataBean> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  TopArticleBean(this.data,this.errorCode,this.errorMsg,);

  factory TopArticleBean.fromJson(Map<String, dynamic> srcJson) => _$TopArticleBeanFromJson(srcJson);

}




TopArticleBean _$TopArticleBeanFromJson(Map<String, dynamic> json) {
  return TopArticleBean(
      (json['data'] as List)
          ?.map((e) =>
      e == null ? null : TopArticleDataBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$TopArticleBeanToJson(TopArticleBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };



Map<String, dynamic> _$DataToJson(TopArticleDataBean instance) => <String, dynamic>{
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
