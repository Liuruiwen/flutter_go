import 'package:flutter/material.dart';
import 'package:flutter_go/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2019/8/28.
 * Desc:加载完成
 */

class LoadingFinishToast extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child:new Center(child:  new Text("没有更多数据"),),
      height: ScreenUtil.getInstance().setHeight(Dimens.go_i_dp80),
    );
  }

}
