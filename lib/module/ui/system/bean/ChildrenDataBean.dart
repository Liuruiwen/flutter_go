import 'package:json_annotation/json_annotation.dart';

import 'SystemDataBean.dart';

/**
 * Created by Amuser
 * Date:2019/8/9.
 * Desc:
 */

@JsonSerializable()
class ChildrenDataBean extends Object {

  @JsonKey(name: 'children')
  List<SystemDataBean> children;

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

  @JsonKey(name: 'selectType')
  int selectType;


  ChildrenDataBean(this.children,this.courseId,this.id,this.name,this.order,this.parentChapterId,this.userControlSetTop,this.visible,this.selectType,);

  factory ChildrenDataBean.fromJson(Map<String, dynamic> srcJson) => _$ChildrenDataBeanFromJson(srcJson);

}

ChildrenDataBean _$ChildrenDataBeanFromJson(Map<String, dynamic> json) {
  return ChildrenDataBean(
      (json['children'] as List)
          ?.map((e) =>
      e == null ? null : SystemDataBean.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['courseId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['userControlSetTop'] as bool,
      json['visible'] as int,
      json['selectType'] as int
  );
}
