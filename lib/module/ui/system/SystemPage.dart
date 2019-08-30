import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseStateWidget.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';
import 'package:flutter_go/module/base/widget/WebViewPage.dart';
import 'package:flutter_go/module/http/HttpHelper.dart';
import 'package:flutter_go/module/ui/home/bean/NavigationBean.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ApiConfig.dart';
import 'ArticleListWidget.dart';
import 'bean/ChildrenDataBean.dart';
import 'bean/CodeSystemBean.dart';
import 'bean/SystemDataBean.dart';

/**
 * Created by Amuser
 * Date:2019/8/2.
 * Desc:结构
 */
class SystemPage extends BaseFulWidget {
  BuildContext context;

  SystemPage(this.context);

  @override
  CollectionState createState() {
    // TODO: implement createState
    return new CollectionState();
  }

  treeList(bool isLoad, BuildContext context, int page, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad,
        ApiConfig.GO_NAV_LIST);
    filtration(isLoad, context, response, (t) {
      callBack(NavigationBean.fromJson(t));
    });
  }


}

class CollectionState extends BaseStateWidget<SystemPage>
    with AutomaticKeepAliveClientMixin {
  List<NavigationData> _listChildren = new List();
  List<NavigationArticles> _listSystem = new List();
  int _beforePosition=0;
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    screen(context);
    return new Scaffold(
        body: _getBodyWidget());
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getData());
  }

  _getData() async {
    await widget.treeList(true, widget.context, 1, (t) {
      NavigationBean bean = t;
      setState(() {
        print(bean.data[0].name);
        _listChildren.addAll(bean.data);
        _listChildren[0].selectType=1;
        _listSystem = bean.data[0].articles;
      });
    });
  }


  Widget _getBodyWidget() {
    return new Row(
      children: <Widget>[
        new Container(
          child: _getListView(),
          width: 100,
        ),
//          VerticalDivider(color: Colors.grey),//垂直横线
        new Expanded(child:new Container(
          child:  _getGridView(),
          padding: EdgeInsets.all(5),
        ))
      ],
    );
  }

  Widget _getListView() {
    return new ListView.builder(
      itemCount: _listChildren.length,
      itemBuilder: (buildContext, position) {
        return new Column(
          children: <Widget>[
            _getListItem(_listChildren[position],position),
            new LineWidget(),
          ],
        );
      },
    );
  }

  Widget _getGridView() {
    return new GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 8 /5,
        children: List.generate(_listSystem.length, (i) {
          return _getGridItem(_listSystem[i]);
        },
        ));
  }

  Widget _getListItem(NavigationData bean,int position) {
    return new GestureDetector(
      child: new Container(
        child: new Center(child: new Text(bean.name,style: TextStyle(color:  bean.selectType==1?Colors.white:Colours.text_normal),),),
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        height: 60,
        decoration: BoxDecoration(
          color: bean.selectType==1?Colors.blue:Colors.white,
        ),
      ),
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if(_beforePosition!=position){
            _listChildren[_beforePosition].selectType=0;
            _listChildren[position].selectType=1;
            _beforePosition=position;
            _listSystem = bean.articles;
          }

        });
      },
    );
  }

  Widget _getGridItem(NavigationArticles bean) {
    return new Container(
      child: new GestureDetector(
        child: new Center(child: new Text(bean.title,style: TextStyle(
            color: Colors.blue,
             fontSize:ScreenUtil.getInstance().setSp(20),
        ),),),
        behavior: HitTestBehavior.opaque,
        onTap: (){
          pushWidget(widget.context, new WebViewPage(bean.title, bean.link), false);
        },
      ),padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        border: new Border.all(color: Colors.blue, width: 0.5),
        color: Colors.white, // 底色
        borderRadius: new BorderRadius.vertical(
            top: Radius.elliptical(10, 10),
            bottom: Radius.elliptical(10, 10)), // 也可控件一边圆角大小
      ),
      height: 30,

    );
  }



}

