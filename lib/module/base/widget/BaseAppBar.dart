import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

/**
 * Created by Amuser
 * Date:2019/7/25.
 * Desc:头部处理
 */
class BaseAppBar extends StatefulWidget {
  String title;
  Function onLeftBack;
  Function onRightBack;
  String rightContent;
  IconData Icons;
  bool isLeftIcon;

  BaseAppBar(this.isLeftIcon, this.Icons, this.title, this.rightContent,
      this.onLeftBack, this.onRightBack);

  @override
  BaseAppBarState createState() {
    // TODO: implement createState
    return new BaseAppBarState();
  }
}

class BaseAppBarState extends State<BaseAppBar> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new GestureDetector(
                  child: new Container(
                    child: new Icon(
                      widget.isLeftIcon ? widget.Icons : null, size: 30,
                      color: Colors.white,),
                    padding: EdgeInsets.only(left: 5),
                  ),
                  onTap: widget.onLeftBack,
                ), new GestureDetector(
                  child: new Text(
                    widget.rightContent == null ? "" : widget.rightContent,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(30),
                    ),),
                  onTap: widget.onRightBack,
                ),
              ],
            ),
          ), new Center(child: new Container(
            child: new Container(
              child: new Text(widget.title, style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(30),
                color: Colors.white,

              ), maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,),
              width: ScreenUtil.getInstance().setWidth(200),
            ),)
          ),
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


  Widget _newTitle() {
    return new Container(
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              child: new Container(
                child: new Icon(
                  widget.isLeftIcon ? widget.Icons : null, size: 30,
                  color: Colors.white,),
                padding: EdgeInsets.only(left: 15),
              ),
              onTap: widget.onLeftBack,
            ),
            new Expanded(child: new Center(child: new Container(
              child: new Text(widget.title, style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(30),
                color: Colors.white,
              ), maxLines: 1, overflow: TextOverflow.ellipsis),
            ),

            )),
            new GestureDetector(
              child: new Text(
                widget.rightContent == null ? "" : widget.rightContent,
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(30),
                  color: Colors.white,
                ),),
              onTap: widget.onRightBack,
            ),
          ],
        ),
      ),
      margin: EdgeInsets.only(top: MediaQueryData
          .fromWindow(window)
          .padding
          .top),
      decoration: BoxDecoration(color: Colors.blue),
      height: ScreenUtil.getInstance().setHeight(100),
    );
  }


}