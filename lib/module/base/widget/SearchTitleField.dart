import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

/**
 * Created by Amuser
 * Date:2019/7/25.
 * Desc:搜索
 */
class SearchTitleField extends StatefulWidget {
  final Function onLeftBack;
  final IconData Icons;
  final bool isLeftIcon;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String hintContent;
  final bool hasSuffixIcon;
  final EdgeInsetsGeometry margin;
  final Function submitText;


  const SearchTitleField(
      { Key key,this.onLeftBack,this.Icons,this.isLeftIcon=true, this.controller, this.prefixIcon, this.hintContent,
        this.margin,
        this.hasSuffixIcon = false,this.submitText}) : super(key: key);

  @override
  SearchTitleState createState() {
    // TODO: implement createState
    return new SearchTitleState();
  }
}

class SearchTitleState extends State<SearchTitleField> {
  bool _obscureText;


  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _topTitle();
  }


  Widget _topTitle() {
    return new Container(
      child: new Stack(
        children: <Widget>[
          new Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new GestureDetector(
                  child: new Container(
                    child: new Icon(
                      widget.isLeftIcon ? widget.Icons : null, size: 30,
                      color: Colors.white,),
                    padding: EdgeInsets.only(left: 5),
                  ),
                  onTap: widget.onLeftBack,
                ),new Expanded(child:new Center(child: _getBorderText(),) )
              ],
            ),
          )
        ],
      ),
      margin: EdgeInsets.fromLTRB(0, MediaQueryData
          .fromWindow(window)
          .padding
          .top, 0, 0),
      decoration: BoxDecoration(color: Colors.blue),
      height: ScreenUtil.getInstance().setHeight(100),
    );
  }




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
        borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
      ),
      alignment: Alignment.center,
      height: ScreenUtil.getInstance().setHeight(60),
      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10, 0),
      child:  new Stack(
        children: <Widget>[
          new Container(
            child: new Center(child: new Icon(Icons.search, size: 20,
              color: Colors.blue,),),
            padding: EdgeInsets.only(left: 15),
            width: ScreenUtil.getInstance().setWidth(60),
          ),
         new Center(child: new Padding(padding: EdgeInsets.only(left: 30,right: 30),child:  _getTextField(),))
        ],
      ),
    );
  }



}