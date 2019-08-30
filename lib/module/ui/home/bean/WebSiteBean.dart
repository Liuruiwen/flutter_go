/**
 * Created by Amuser
 * Date:2019/8/20.
 * Desc:常用网站
 */
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class WebSiteBean extends Object{

  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  WebSiteBean(this.data,this.errorCode,this.errorMsg,);

  factory WebSiteBean.fromJson(Map<String, dynamic> srcJson) => _$WebSiteBeanFromJson(srcJson);

}


@JsonSerializable()
class Data extends Object{

  @JsonKey(name: 'icon')
  String icon;

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

  Data(this.icon,this.id,this.link,this.name,this.order,this.visible,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}

WebSiteBean _$WebSiteBeanFromJson(Map<String, dynamic> json) {
  return WebSiteBean(
      (json['data'] as List)
          ?.map((e) =>
      e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$WebSiteBeanToJson(WebSiteBean instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(json['icon'] as String, json['id'] as int, json['link'] as String,
      json['name'] as String, json['order'] as int, json['visible'] as int);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'icon': instance.icon,
  'id': instance.id,
  'link': instance.link,
  'name': instance.name,
  'order': instance.order,
  'visible': instance.visible
};


