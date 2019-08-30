import 'package:flutter/material.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 *
 * http://www.imooc.com/article/285750  flutter sp
 * Created by Amuser
 * Date:2019/7/28.
 * Desc:
 */

class ItemTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String hintContent;
  final bool hasSuffixIcon;
  final EdgeInsetsGeometry margin;


  const ItemTextField(
      { Key key, this.controller, this.prefixIcon, this.hintContent,
        this.margin,
        this.hasSuffixIcon = false}) : super(key: key);

  @override
  ItemTextFiledState createState() {
    // TODO: implement createState
    return new ItemTextFiledState();
  }

}


class ItemTextFiledState extends State<ItemTextField> {
  bool _obscureText;


  @override
  void initState() {
    super.initState();
    _obscureText = widget.hasSuffixIcon;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Icon(widget.prefixIcon, size: 30, color: Colors.blue,),
            width: ScreenUtil.getInstance().setWidth(100),
            height: ScreenUtil.getInstance().setHeight(120),
          ),

          new Expanded(
            child: new Container(
              child: _getTextField(),
              margin: EdgeInsets.only(left: 0),
            ),),

        ],),
      margin:widget.margin==null?EdgeInsets.fromLTRB(30, 10, 30, 0):widget.margin,
    );
  }


  Widget _getTextField() {
    return new TextField(
      controller: widget.controller,
      maxLines: 1,
      maxLength: 16,
      autocorrect: true,
      //是否自动更正
      autofocus: true,
      //是否自动对焦
      obscureText: _obscureText,
      //是否是密码
      textAlign: TextAlign.center,
      decoration: new InputDecoration(
        hintText: widget.hintContent,
        hintStyle: new TextStyle(color: Colours.gray_99, fontSize: 14),
        suffixIcon: widget.hasSuffixIcon
            ? new IconButton(
            icon: new Icon(
              _obscureText
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colours.gray_66,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            })
            : null,
        focusedBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Colours.green_de)),
        enabledBorder: new UnderlineInputBorder(
            borderSide: new BorderSide(color: Colours.green_de)),
      ),
      //文本对齐方式
      style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(30),
          color: Colors.blue), //输入文本的样式
    );
  }
}