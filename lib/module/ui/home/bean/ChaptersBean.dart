import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_go/module/base/ObjectBean.dart';
/**
 * Created by Amuser
 * Date:2019/8/19.
 * Desc:公众号
 */



@JsonSerializable()
class ChaptersBean extends ObjectBean {

  @JsonKey(name: 'data')
  List<ChaptersData> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  ChaptersBean(this.data,this.errorCode,this.errorMsg,);

  factory ChaptersBean.fromJson(Map<String, dynamic> srcJson) => _$ChaptersBeanFromJson(srcJson);

}


@JsonSerializable()
class ChaptersData extends Object {

  @JsonKey(name: 'children')
  List<dynamic> children;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'parentChapterId')
  int parentChapterId;

  @JsonKey(name: 'userControlSetTop')
  bool userControlSetTop;

  @JsonKey(name: 'visible')
  int visible;

  ChaptersData(this.children,this.courseId,this.id,this.name,this.order,this.parentChapterId,this.userControlSetTop,this.visible,);

  factory ChaptersData.fromJson(Map<String, dynamic> srcJson) => _$ChaptersDataFromJson(srcJson);

}
ChaptersBean _$ChaptersBeanFromJson(Map<String, dynamic> json) {
  return ChaptersBean(
      (json['data'] as List)
          ?.map((e) =>
      e == null ? null : ChaptersData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String)
    ..ObjectType = json['ObjectType'] as int
    ..itemPostion = json['itemPostion'] as int;
}

Map<String, dynamic> _$ChaptersBeanToJson(ChaptersBean instance) =>
    <String, dynamic>{
      'ObjectType': instance.ObjectType,
      'itemPostion': instance.itemPostion,
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

ChaptersData _$ChaptersDataFromJson(Map<String, dynamic> json) {
  return ChaptersData(
      json['children'] as List,
      json['courseId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['userControlSetTop'] as bool,
      json['visible'] as int);
}

Map<String, dynamic> _$DataToJson(ChaptersData instance) => <String, dynamic>{
  'children': instance.children,
  'courseId': instance.courseId,
  'id': instance.id,
  'name': instance.name,
  'order': instance.order,
  'parentChapterId': instance.parentChapterId,
  'userControlSetTop': instance.userControlSetTop,
  'visible': instance.visible
};
