import 'package:flutter_go/module/base/ObjectBean.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Amuser
 * Date:2019/8/20.
 * Desc:搜索热词
 */




@JsonSerializable()
class HotSeachBean extends ObjectBean{

  @JsonKey(name: 'data')
  List<HotSeachData> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  HotSeachBean(this.data,this.errorCode,this.errorMsg,);

  factory HotSeachBean.fromJson(Map<String, dynamic> srcJson) => _$HotSeachBeanFromJson(srcJson);

}


@JsonSerializable()
class HotSeachData extends Object{

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'visible')
  int visible;

  HotSeachData(this.id,this.link,this.name,this.order,this.visible,);

  factory HotSeachData.fromJson(Map<String, dynamic> srcJson) => _$HotSeachDataFromJson(srcJson);

}


HotSeachBean _$HotSeachBeanFromJson(Map<String, dynamic> json) {
  return HotSeachBean(
      (json['data'] as List)
          ?.map((e) =>
      e == null ? null : HotSeachData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$HotSeachBeanToJson(HotSeachBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

HotSeachData _$HotSeachDataFromJson(Map<String, dynamic> json) {
  return HotSeachData(json['id'] as int, json['link'] as String, json['name'] as String,
      json['order'] as int, json['visible'] as int);
}

Map<String, dynamic> _$DataToJson(HotSeachData instance) => <String, dynamic>{
  'id': instance.id,
  'link': instance.link,
  'name': instance.name,
  'order': instance.order,
  'visible': instance.visible
};