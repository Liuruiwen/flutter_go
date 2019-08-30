import 'package:flutter/material.dart';
import 'package:flutter_go/module/ui/home/bean/NewListDataBean.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_go/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'LineWidget.dart';
import 'WebViewPage.dart';

/**
 * Created by Amuser
 * Date:2019/8/29.
 * Desc:
 */

class ChaptersWidget extends StatelessWidget {
  NewListDataBean _dataBean;
  BuildContext _context;

  ChaptersWidget(this._dataBean, this._context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getListItems(_dataBean);
  }




  /**
   * 给ITem添加下划线
   */
  Widget _getListItems(NewListDataBean dataBean) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new LineWidget(),
          new GestureDetector(
            child: _getItem(dataBean),
            onTap: () {
              _ItemClick(dataBean.title, dataBean.link);
            },
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    );
  }


  /**
   * 获取列表Item
   */
  Widget _getItem(NewListDataBean bean) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(child: _getRowItem(bean))
          , new Column(
            children: <Widget>[
              new Image(image: new NetworkImage(bean.envelopePic),
                width: ScreenUtil.getInstance().setWidth(Dimens.go_i_dp150),
                height: ScreenUtil.getInstance().setHeight(Dimens.go_i_dp260),
                fit: BoxFit.cover,
              ),
              new Container(),
            ],
          )
        ],
      ),
      padding: EdgeInsets.all(5),
    );
  }


  Widget _getRowItem(NewListDataBean bean) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Align(
          child: new Text(bean.title, style: TextStyle(
            color: Colours.text_dark,
            fontSize: ScreenUtil.getInstance().setSp(30),
            fontWeight: FontWeight.bold,
          ),
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ), alignment: Alignment.topLeft,
        ),
        new Container(child: new Align(
          child: new Text(bean.desc, style: TextStyle(
            color: Colours.text_normal,
            fontSize: ScreenUtil.getInstance().setSp(30),
            fontWeight: FontWeight.bold,
          ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ), alignment: Alignment.topLeft,
        ),
          margin: EdgeInsets.only(top: 5),
          height: ScreenUtil.getInstance().setHeight(140),
        ),
        new Container(
          child: new Row(
            children: <Widget>[
              new Text("作者：" + bean.author,
                style: TextStyle(color: Colours.text_gray,),),
              new Expanded(child: new Container(
                child: new Text("时间：" + bean.niceDate,
                  style: TextStyle(color: Colours.text_gray,)
                  , textAlign: TextAlign.right,
                ),
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ))
            ],
          ),
          margin: EdgeInsets.only(top: 20),
        ),

      ],
    );
  }

  _ItemClick(String title, String url) {
    pushWidget(_context, new WebViewPage(title, url), false);
  }

  /**
   * 页面跳转
   */
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
}