import 'package:flutter_go/module/base/ObjectBean.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by Amuse
 * Date:2019/7/8.
 * Desc:
 */

@JsonSerializable(nullable: false)
 class BannerBean extends ObjectBean{
//  NewsBean.fromJson(Map<String, > srcJson) : super.fromJson(srcJson);
   @JsonKey(name: 'data')
   List<Data> data;

   @JsonKey(name: 'errorCode')
   int errorCode;

   @JsonKey(name: 'errorMsg')
   String errorMsg;


   BannerBean(this.data, this.errorCode, this.errorMsg);

   factory BannerBean.fromJson(Map<String, dynamic> srcJson) => _$BannerBeanFromJson(srcJson);

 }


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imagePath')
  String imagePath;

  @JsonKey(name: 'isVisible')
  int isVisible;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'url')
  String url;

  Data(this.desc,this.id,this.imagePath,this.isVisible,this.order,this.title,this.type,this.url,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}

BannerBean _$BannerBeanFromJson(Map<String, dynamic> json) {
  return BannerBean(
      (json['data'] as List)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$TestBeanToJson(BannerBean instance) => <String, dynamic>{
  'data': instance.data,
  'errorCode': instance.errorCode,
  'errorMsg': instance.errorMsg
};

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['desc'] as String,
      json['id'] as int,
      json['imagePath'] as String,
      json['isVisible'] as int,
      json['order'] as int,
      json['title'] as String,
      json['type'] as int,
      json['url'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'desc': instance.desc,
  'id': instance.id,
  'imagePath': instance.imagePath,
  'isVisible': instance.isVisible,
  'order': instance.order,
  'title': instance.title,
  'type': instance.type,
  'url': instance.url
};

