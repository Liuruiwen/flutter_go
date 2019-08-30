/**
 * Created by Amuser
 * Date:2019/8/20.
 * Desc:表格布局
 */

import 'package:flutter/material.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseGridView extends StatefulWidget {

  final  List<Widget> listWidget;//容器列表
  final int lineCount;//行数
  final Axis axis;//显示方向，垂直和水平
  final double crossAxisSpacing;//水平间距
  final double mainAxisSpacing;//横向间距
  final double childAspectRatio;//宽高比列

  const BaseGridView({Key key, this.listWidget, this.lineCount=3, this.axis=Axis.vertical,
      this.crossAxisSpacing=8.0, this.mainAxisSpacing=8.0,
      this.childAspectRatio=7/4}) : super(key: key);


  @override
  GridState createState() {
    // TODO: implement createState
    return new GridState();
  }

}


class GridState extends State<BaseGridView> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getGridView();
  }


  Widget _getGridView( ) {
    return new GridView.count(
        physics: new NeverScrollableScrollPhysics(),//增加
        shrinkWrap: true,
        crossAxisCount: widget.lineCount,
        //设置水平
        scrollDirection: widget.axis,
        //设置水平
        crossAxisSpacing: widget.crossAxisSpacing,
        //横向间距
        mainAxisSpacing: widget.mainAxisSpacing,
        //宽高比
        childAspectRatio: widget.childAspectRatio,
        //宽高比列设置
        //横向间距
        children: widget.listWidget);
  }
}