import 'package:flutter/material.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2019/8/20.
 * Desc:标注
 */

class TextMark extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignmentGeometry;//内容显示位置
  final Color fontColor;
  final Color bgColor;
  final int height;
  final  EdgeInsets  padding;
  final EdgeInsets  magin;
  const TextMark({Key key,this.text, this.alignmentGeometry=Alignment.centerLeft, this.fontColor=Colours.text_dark, this.bgColor=Colours.gray_line,
      this.height=80, this.padding,this.magin}): super(key: key); //内边距设置
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getTextMark(context);
  }

  Widget _getTextMark(BuildContext buildContext) {
    return  new Container(
      child: new Align(
        child: new Text(text, style: TextStyle(color: fontColor),),
        alignment:alignmentGeometry,

      ),
      decoration: BoxDecoration(
          color: bgColor
      ),
      height: ScreenUtil.getInstance().setHeight(height),
      padding:padding,
      margin: magin,
    );
  }
}