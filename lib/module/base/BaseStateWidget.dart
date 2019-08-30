import 'package:flutter/material.dart';
import 'package:flutter_go/module/ui/bean/ResultCode.dart';
import 'package:flutter_go/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'BaseFulWidget.dart';


/**
 * Created by Amuser
 * Date:2019/8/5.
 * Desc:
 */
abstract class BaseStateWidget<T extends BaseFulWidget> extends State<T> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screen(context);
    return getBuildWidget(context);
  }

  void screen(BuildContext buildContext) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(buildContext);
    initLis(buildContext);
  }

  double getHeight(int height) {
    return ScreenUtil.getInstance().setHeight(height);
  }

  double getWidth(int width) {
    return ScreenUtil.getInstance().setHeight(width);
  }

  void initLis(BuildContext buildContext) {

  }

  Color setThemeColor() {
    return Colors.red;
  }


  Widget getBuildWidget(BuildContext buildContext) {
    return new Center(child: new Text("请重新编写widget"),);
  }


  void showToast(String msg) {
    widget.showToast(msg);
  }


  void pushWidget(BuildContext buildContext
      , Widget widget, bool isClose) {
    if (isClose) {
      Navigator.pushAndRemoveUntil(
          buildContext, new MaterialPageRoute(builder: (BuildContext context) {
        return widget;
      }), (route) => route == null);
    } else {
      Navigator.push(
          buildContext,
          MaterialPageRoute(builder: (context) => widget));
    }
  }

  pushForWidget(BuildContext buildContext
      , Widget widget) async {
    return await Navigator.push( //等待
        buildContext,
        MaterialPageRoute(builder: (context) => widget));
  }


  void closeWidget() {
    Navigator.pop(context);
  }

  void closeForWidget(ResultCode result) async {
    Navigator.pop(context, result);
    print("经过了这里？？");
  }


  void closePageForWidget(BuildContext buildContext, Widget widget) {
    Navigator.pushAndRemoveUntil(
        buildContext, new MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }), (route) => route == null);
  }

  Widget setEmptyPage() {
    return new Center(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Image(
                image: new AssetImage('image/gift_bill_list_empty.png'),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: ScreenUtil.getInstance().setHeight(Dimens.go_i_dp300),
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.only(left: 80, right: 80, bottom: 30),
            ),
            new Expanded(child:   new Text("亲，没有数据哦！"),)

          ],
        ),
        height: ScreenUtil.getInstance().setHeight(Dimens.go_i_dp400),
      ),
    );
  }


}
