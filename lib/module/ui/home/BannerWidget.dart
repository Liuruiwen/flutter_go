import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseStateWidget.dart';
import 'package:flutter_go/module/base/ObjectBean.dart';
import 'package:flutter_go/module/base/widget/ChaptersWidget.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';
import 'package:flutter_go/module/base/widget/TextMark.dart';
import 'package:flutter_go/module/base/widget/WebViewPage.dart';
import 'package:flutter_go/module/http/HttpHelper.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_go/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ApiConfig.dart';
import 'ChaptersListWidget.dart';
import 'HotArticleWidget.dart';
import 'WxArticleListWidget.dart';
import 'bean/BannerBean.dart';
import 'bean/ChaptersBean.dart';
import 'bean/NewListProjectBean.dart';

/**
 * Created by Amuser
 * Date:2019/8/19.
 * Desc:
 */
class BannerWidget extends BaseFulWidget {
  BuildContext context;

  BannerWidget(this.context);

  @override
  HomePageState createState() {
    // TODO: implement createState
    return new HomePageState();
  }

  banner(bool isLoad, BuildContext context, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad, ApiConfig.GO_BANNER);
    filtration(isLoad, context, response, (t) {
      callBack(BannerBean.fromJson(t));
    });
  }

  chapters(bool isLoad, BuildContext context, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad, ApiConfig.GO_CHAPTERS_LIS);
    filtration(isLoad, context, response, (t) {
      callBack(ChaptersBean.fromJson(t));
    });
  }

  newList(bool isLoad, BuildContext context, int page, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad,
        ApiConfig.GO_NEW_PROJECT_LIST + page.toString() + "/json");
    filtration(isLoad, context, response, (t) {
      callBack(NewListProjectBean.fromJson(t));
    });
  }

}

class HomePageState extends BaseStateWidget<BannerWidget>
    with AutomaticKeepAliveClientMixin {

  List<ObjectBean> listBean = new List();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screen(context);
    return new Scaffold(
        body: _getListView(context)
    );
  }

  int count = 0;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _getData() async {
    await widget.banner(true, widget.context, (t) {
      setState(() {
        BannerBean _bannerBean = t;
        _bannerBean.itemPostion = 0;
        listBean.add(_bannerBean);
      });
    });

    await widget.chapters(true, widget.context, (t) {
      setState(() {
        ObjectBean objectBean = new ObjectBean();
        objectBean.itemPostion = 1;
        listBean.add(objectBean);
        ChaptersBean _chaptersBean = t;
        _chaptersBean.itemPostion = 2;
        listBean.add(_chaptersBean);
        ObjectBean objectBean1 = new ObjectBean();
        objectBean1.itemPostion = 3;
        listBean.add(objectBean1);
      });
    });
//


    await widget.newList(true, widget.context, 1, (t) {
      NewListProjectBean bean = t;
      setState(() {
        print(bean.data.datas[0].title);
        listBean.addAll(bean.data.datas);
      });
    });
  }

  Widget _getListView(BuildContext buildContext) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listBean.length,
      itemBuilder: (buildContext, position) {
        return _getListTitle(listBean[position]);
      },

    );
  }


  Widget _getListTitle(ObjectBean bean) {
    switch (bean.itemPostion) {
      case 0:
        return getBanner(bean);
      case 1:
        return _getTextMark("公众号达人");
      case 2:
        return _ColumnWeiXin(bean);
      case 3:
        return _getMoreChapters();
      default:
        return ChaptersWidget(bean, widget.context);
    }
  }

  Widget _getTextMark(String content) {
    return new TextMark(
      text: content,
      padding: EdgeInsets.all(8),
    );
  }

  Widget _getMoreChapters() {
    return new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text("热门项目",style: TextStyle(color: Colours.text_dark),),
            new GestureDetector(
              child: new Text("更多》", style: TextStyle(color: Colors.blue),),
              onTap: () {
                pushWidget(widget.context,
                    new ChaptersListWidget(), false);
              },
            )
          ],
        ),
        padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colours.gray_line
      ),
    );
  }

  Widget getBanner(BannerBean bean) {
    return new Container(
      child: _bannerView(bean),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.3,
    );
  }

  _bannerView(BannerBean bean) {
    List<Widget> _list = bean?.data?.map((item) {
      return new GestureDetector(
        child: Image.network(item.imagePath, fit: BoxFit.cover),
        onTap: () {
          _ItemClick(item.title, item.url);
        },
      );
    })?.toList();
    return _list == null
        ? Text("当前没有数据")
        : new BannerView(
      _list,
      intervalDuration: const Duration(seconds: 3),
    );
  }


  Widget _ColumnWeiXin(ChaptersBean bean) {
    List<Widget> list = bean.data.map<Widget>((ChaptersData data) {
      return new GestureDetector(
        child: new Container(child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Align(child: new Text(data.name, style: TextStyle(
                color: Colours.text_dark,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil.getInstance().setSp(30),
              ), maxLines: 1,
                overflow: TextOverflow.ellipsis,),
                alignment: Alignment.topLeft,
              ),
            ),
            new Container(
              child: new Center(child: new Text(
                "公众号", style: TextStyle(color: Colors.white,
                  fontSize: ScreenUtil.getInstance().setSp(22)),),),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, //可以设置角度，BoxShape.circle直接圆形
                  color: Colors.blue
              ),
              width: ScreenUtil.getInstance().setWidth(Dimens.go_i_dp80),
              height: ScreenUtil.getInstance().setWidth(Dimens.go_i_dp80),
            )
          ],
        ),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          decoration: BoxDecoration(
              border: new Border(
                bottom: new BorderSide(width: 0.33, color: Colours.gray_line),
              )
          ),
        ),
        onTap: () {
          pushWidget(widget.context,
              new WxArticleListWidget(data.name, data.id.toString()), false);
        },

      );
    }).toList();
    return new Column(children: list,);
  }

  _ItemClick(String title, String url) {
    pushWidget(widget.context, new WebViewPage(title, url), false);
  }

}