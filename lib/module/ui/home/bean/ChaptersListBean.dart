/**
 * Created by Amuser
 * Date:2019/8/19.
 * Desc:
 */

import 'package:json_annotation/json_annotation.dart';

import 'ChaptersDatasBean.dart';



@JsonSerializable()
class ChaptersListBean extends Object{

  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  ChaptersListBean(this.data,this.errorCode,this.errorMsg,);

  factory ChaptersListBean.fromJson(Map<String, dynamic> srcJson) => _$ChaptersListBeanFromJson(srcJson);

}


@JsonSerializable()
class Data extends Object{

  @JsonKey(name: 'curPage')
  int curPage;

  @JsonKey(name: 'datas')
  List<ChaptersDatasBean> datas;

  @JsonKey(name: 'offset')
  int offset;

  @JsonKey(name: 'over')
  bool over;

  @JsonKey(name: 'pageCount')
  int pageCount;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'total')
  int total;

  Data(this.curPage,this.datas,this.offset,this.over,this.pageCount,this.size,this.total,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}






ChaptersListBean _$ChaptersListBeanFromJson(Map<String, dynamic> json) {
  return ChaptersListBean(
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$ChaptersListBeanToJson(ChaptersListBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['curPage'] as int,
      (json['datas'] as List)
          ?.map((e) =>
      e == null ? null : ChaptersDatasBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'curPage': instance.curPage,
  'datas': instance.datas,
  'offset': instance.offset,
  'over': instance.over,
  'pageCount': instance.pageCount,
  'size': instance.size,
  'total': instance.total
};



Map<String, dynamic> _$DatasToJson(ChaptersDatasBean instance) => <String, dynamic>{
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



Map<String, dynamic> _$TagsToJson(Tags instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};


