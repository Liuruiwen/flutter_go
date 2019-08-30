/**
 * Created by Amuser
 * Date:2019/8/9.
 * Desc:
 */


import 'package:json_annotation/json_annotation.dart';

import 'ChildrenDataBean.dart';
import 'SystemDataBean.dart';



@JsonSerializable()
class CodeSystemBean extends Object {

  @JsonKey(name: 'data')
  List<ChildrenDataBean> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  CodeSystemBean(this.data,this.errorCode,this.errorMsg,);

  factory CodeSystemBean.fromJson(Map<String, dynamic> srcJson) => _$CodeSystemBeanFromJson(srcJson);

}








CodeSystemBean _$CodeSystemBeanFromJson(Map<String, dynamic> json) {
  return CodeSystemBean(
      (json['data'] as List)
          ?.map((e) =>
      e == null ? null : ChildrenDataBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$CodeSystemBeanToJson(CodeSystemBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };



Map<String, dynamic> _$DataToJson(ChildrenDataBean instance) => <String, dynamic>{
  'children': instance.children,
  'courseId': instance.courseId,
  'id': instance.id,
  'name': instance.name,
  'order': instance.order,
  'parentChapterId': instance.parentChapterId,
  'userControlSetTop': instance.userControlSetTop,
  'visible': instance.visible
};



Map<String, dynamic> _$ChildrenToJson(SystemDataBean instance) => <String, dynamic>{
  'children': instance.children,
  'courseId': instance.courseId,
  'id': instance.id,
  'name': instance.name,
  'order': instance.order,
  'parentChapterId': instance.parentChapterId,
  'userControlSetTop': instance.userControlSetTop,
  'visible': instance.visible
};
