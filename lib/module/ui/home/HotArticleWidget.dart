import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseStateWidget.dart';
import 'package:flutter_go/module/base/ObjectBean.dart';
import 'package:flutter_go/module/base/widget/BaseGridView.dart';
import 'package:flutter_go/module/base/widget/ChipsTitle.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';
import 'package:flutter_go/module/base/widget/TextMark.dart';
import 'package:flutter_go/module/base/widget/WebViewPage.dart';
import 'package:flutter_go/module/http/HttpHelper.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ApiConfig.dart';
import 'SearchWidget.dart';
import 'bean/HotSeachBean.dart';
import 'bean/TopArticleBean.dart';
import 'bean/TopArticleDataBean.dart';

/**
 * Created by Amuser
 * Date:2019/8/20.
 * Desc:热门
 */

class HotArticleWidget extends BaseFulWidget {
  BuildContext context;

  HotArticleWidget(this.context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HotState();
  }

  hotKey(bool isLoad, BuildContext context, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad, ApiConfig.GO_HOT_KEY);
    filtration(isLoad, context, response, (t) {
      callBack(HotSeachBean.fromJson(t));
    });
  }

  webSite(bool isLoad, BuildContext context, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad, ApiConfig.GO_WEB_SITE);
    filtration(isLoad, context, response, (t) {
      callBack(HotSeachBean.fromJson(t));
    });
  }

  topArticle(bool isLoad, BuildContext context, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad, ApiConfig.GO_TOP_ARTICLE);
    filtration(isLoad, context, response, (t) {
      callBack(TopArticleBean.fromJson(t));
    });
  }


}

class HotState extends BaseStateWidget<HotArticleWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<ObjectBean> listBean = new List();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screen(context);
    return new Scaffold(
      body: _getListView(context),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count++;
    if (count == 1) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _getData());
    }
  }


  _getData() async {
    await widget.hotKey(true, widget.context, (t) {
      setState(() {
        HotSeachBean _bannerBean = t;
        _bannerBean.itemPostion = 0;
        listBean.add(_bannerBean);

      });
    });

    await widget.webSite(true, widget.context, (t) {
      setState(() {
        HotSeachBean _chaptersBean = t;
        _chaptersBean.itemPostion =1;
        listBean.add(_chaptersBean);
        ObjectBean objectBeans=new ObjectBean();
        objectBeans.itemPostion=2;
        listBean.add(objectBeans);
      });
    });
//

    await widget.topArticle(true, widget.context, (t) {
      setState(() {
        TopArticleBean topArticleBean = t;
        listBean.addAll(topArticleBean.data);
      });
    });
  }


  Widget _getListView(BuildContext buildContext) {
    return ListView.builder(
      itemCount: listBean.length,
      itemBuilder: (buildContext, position) {
        return _getListTitle(listBean[position]);
      },
    );
  }


  Widget _getListTitle(ObjectBean bean) {
    switch (bean.itemPostion) {
      case 0:
        return _getGrid( bean,"搜索热词",1);
      case 1:
        return _getGrid( bean,"常用网站",0);
      case 2:
        return _getTextMark("置顶资讯");
      default:
        return _getListItem(bean);
    }
  }


  Widget _getTextMark(String content){
    return new TextMark(
      text: content,
      padding: EdgeInsets.all(8),
    );
  }


  Widget _getListItem(TopArticleDataBean bean) {
    return new GestureDetector(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Align(
              alignment: Alignment.topLeft,
              widthFactor: 2.0,
              heightFactor: 1.0,
              child: new Text(bean.title),
            ),
            new Container(
              child: new Row(
                children: <Widget>[
                  new Container(
                    child: new Text("作者：" + bean.author,
                      style: TextStyle(color: Colours.text_gray,),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  new Expanded(child: new Container(
                    child: new Text("时间：" + bean.niceDate,
                      style: TextStyle(color: Colours.text_gray,)
                      , textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  ))
                ],
              ),
              margin: EdgeInsets.only(top: 20, bottom: 5),
            ),
            new LineWidget(),

          ],
        ),
        padding: EdgeInsets.only(left: 10,right: 10),
      ),
      onTap: (){
        pushWidget(widget.context, new WebViewPage(bean.title, bean.link), false);
      },
    );
  }





  Widget _getGrid(HotSeachBean bean,String name,int type){
    final List<Widget> chips =bean.data.map<Widget>((HotSeachData _model) {
      return new GestureDetector(
        child: Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          key: ValueKey<String>(_model.name),
          backgroundColor: Colors.blue,
          label: Text(
            _model.name,
            style: new TextStyle(fontSize: 14.0,color: Colors.white),
          ),
        ),
        behavior: HitTestBehavior.opaque,
        onTap: (){
          switch(type){
            case 0:
              pushWidget(widget.context, new WebViewPage(_model.name, _model.link), false);
              break;
            case 1:
              pushWidget(widget.context, new SearchWidget(_model.name), false) ;
              break;
          }
        },
      );
    }).toList();
    return new ChipsTitle(
      label:name,
      children: chips,
    );
  }

}