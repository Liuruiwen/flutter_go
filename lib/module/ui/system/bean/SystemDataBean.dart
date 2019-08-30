import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Amuser
 * Date:2019/8/9.
 * Desc:
 */

@JsonSerializable()
class SystemDataBean extends Object {

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

  SystemDataBean(this.children,this.courseId,this.id,this.name,this.order,this.parentChapterId,this.userControlSetTop,this.visible,);

  factory SystemDataBean.fromJson(Map<String, dynamic> srcJson) => _$SystemDataBeanFromJson(srcJson);

}
SystemDataBean _$SystemDataBeanFromJson(Map<String, dynamic> json) {
  return SystemDataBean(
      json['children'] as List,
      json['courseId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['userControlSetTop'] as bool,
      json['visible'] as int);
}