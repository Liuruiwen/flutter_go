
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2019/8/27.
 * Desc:搜索文本框
 * https://www.jianshu.com/p/eb7a9fd82c99
 * https://github.com/mhgd3250905/WANAndroid_Proj
 */

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String hintContent;
  final bool hasSuffixIcon;
  final EdgeInsetsGeometry margin;
  final Function submitText;


  const SearchTextField(
      { Key key, this.controller, this.prefixIcon, this.hintContent,
        this.margin,
        this.hasSuffixIcon = false,this.submitText}) : super(key: key);

  @override
  SearchTextState createState() {
    // TODO: implement createState
    return new SearchTextState();
  }

}


class SearchTextState extends State<SearchTextField> {
  bool _obscureText;


  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  _getBorderText();
  }

// prefixIcon: new Icon(Icons.search),
  Widget _getTextField() {
    return new TextField(
      controller: widget.controller,

      autocorrect: true,
      //是否自动更正
      autofocus: true,
      //是否自动对焦
      obscureText: _obscureText,
      //是否是密码
      textAlign: TextAlign.center,

//      buildCounter:buildCounter,
      decoration: InputDecoration(
        //输入框decoration属性
          contentPadding: new EdgeInsets.only(left: 0.0),
          border: InputBorder.none,

          hintText: widget.hintContent,

          hintStyle: new TextStyle(fontSize: 14, color: Colors.white)),
      //文本对齐方式
      style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(30),
          color: Colors.blue), //输入文本的样式
      onSubmitted:widget.submitText,

    );
  }

  Widget _getBorderText(){
    return Container(
      //修饰黑色背景与圆角
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0), //灰色的一层边框
        color: Colors.white,
//        borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
      ),
      alignment: Alignment.center,
      height: 36,
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: _getTextField(),
    );
  }


}