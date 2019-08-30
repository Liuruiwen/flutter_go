import 'package:flutter_go/module/base/BaseBean.dart';
/**
 * Created by Amuser
 * Date:2019/7/17.
 * Desc:登录实体类
 */

import 'package:json_annotation/json_annotation.dart';



@JsonSerializable()
class LoginBean extends Object {

  @JsonKey(name: 'data')
  Data data;

  @JsonKey(name: 'errorCode')
  int errorCode;

  @JsonKey(name: 'errorMsg')
  String errorMsg;

  LoginBean(this.data,this.errorCode,this.errorMsg);

  factory LoginBean.fromJson(Map<String, dynamic> srcJson) => _$LoginBeanFromJson(srcJson);

  Map toJson(){
    Map map=  new Map();
    map["data"]=this.data;
    map["errorCode"]=this.errorCode;
    map["errorMsg"]=this.errorMsg;
    return map;
  }
}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: 'admin')
  bool admin;

  @JsonKey(name: 'chapterTops')
  List<dynamic> chapterTops;

  @JsonKey(name: 'collectIds')
  List<dynamic> collectIds;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'icon')
  String icon;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'token')
  String token;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'username')
  String username;

  Data(this.admin,this.chapterTops,this.collectIds,this.email,this.icon,this.id,this.nickname,this.password,this.token,this.type,this.username,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map toJson(){
    Map map=  new Map();
    map["admin"]=this.admin;
    map["chapterTops"]=this.chapterTops;
    map["collectIds"]=this.collectIds;
    map["email"]=this.email;
    map["icon"]=this.icon;
    map["id"]=this.id;
    map["nickname"]=this.nickname;
    map["password"]=this.password;
    map["token"]=this.token;
    map["type"]=this.type;
    map["username"]=this.username;
    return map;
  }
}


LoginBean _$LoginBeanFromJson(Map<String, dynamic> json) {
  return LoginBean(
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      json['errorCode'] as int,
      json['errorMsg'] as String);
}

Map<String, dynamic> _$LoginBeanToJson(LoginBean instance) => <String, dynamic>{
  'data': instance.data,
  'errorCode': instance.errorCode,
  'errorMsg': instance.errorMsg
};

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['admin'] as bool,
      json['chapterTops'] as List,
      json['collectIds'] as List,
      json['email'] as String,
      json['icon'] as String,
      json['id'] as int,
      json['nickname'] as String,
      json['password'] as String,
      json['token'] as String,
      json['type'] as int,
      json['username'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'admin': instance.admin,
  'chapterTops': instance.chapterTops,
  'collectIds': instance.collectIds,
  'email': instance.email,
  'icon': instance.icon,
  'id': instance.id,
  'nickname': instance.nickname,
  'password': instance.password,
  'token': instance.token,
  'type': instance.type,
  'username': instance.username
};
