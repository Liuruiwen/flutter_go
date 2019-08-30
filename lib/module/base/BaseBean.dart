import 'package:json_annotation/json_annotation.dart';
/**
 * Created :Auser 
  *  Date: 2019/5/7.
   *  Desc:实体基类
 */
@JsonSerializable()
 class BaseBean extends Object{
 @JsonKey(name: 'errorCode')
 int errorCode;

 @JsonKey(name: 'errorMsg')
 String errorMsg;

 BaseBean(this.errorCode,this.errorMsg,);

 factory BaseBean.fromJson(Map<String, dynamic> srcJson) => _$BaseBeanFromJson(srcJson);

}

BaseBean _$BaseBeanFromJson(Map<String, dynamic> json) {
 return BaseBean(
     json['errorCode'] as int,
     json['errorMsg'] as String);
}