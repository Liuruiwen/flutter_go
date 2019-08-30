import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/widget/ChaptersWidget.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';
import 'package:flutter_go/module/base/widget/LoadingFinishToast.dart';
import 'package:flutter_go/module/base/widget/LoadingMoreToast.dart';
import 'package:flutter_go/module/base/widget/WebViewPage.dart';
import 'package:flutter_go/module/http/HttpHelper.dart';
import 'package:flutter_go/res/Colours.dart';

import '../../ApiConfig.dart';
import 'bean/ChaptersDatasBean.dart';
import 'bean/NewListDataBean.dart';
import 'bean/NewListProjectBean.dart';


/**
 * Created by Amuser
 * Date:2019/8/14.
 * Desc:项目列表
 */
class ChaptersListWidget extends BaseFulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ChaptersListState("项目列表");
  }

  getList(bool isLoad, BuildContext context, int page, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad,
        ApiConfig.GO_NEW_PROJECT_LIST + page.toString() + "/json");
    filtration(isLoad, context, response, (t) {
      callBack(NewListProjectBean.fromJson(t));
    });
  }

}

class ChaptersListState extends BaseWidget<ChaptersListWidget> {
  ChaptersListState(String titles) : super(titles);

  List<NewListDataBean> _list = new List();
  int state = 1;
  int _mPage = 0;
  int pageCount = 0;
  ScrollController _scrollController = new ScrollController(); //滚动监听控件
  final GlobalKey<RefreshIndicatorState> _refresh = new GlobalKey<
      RefreshIndicatorState>(); //刷新控制器

  @override
  Widget setWidget(BuildContext buildContext) {
    // TODO: implement setWidget
    return state == 0 ? setEmptyPage() : _onRefresh();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getData(_mPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_mPage < pageCount) {
          _mPage++;
          _getData(_mPage);
        }
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }


  _getData(int page) async {
    await widget.getList(page > 0 ? false : true, context, page, (t) {
      NewListProjectBean bean = t;

      setState(() {
        if (bean.data.datas.length > 0) {
          pageCount = bean.data.pageCount;
          _list.addAll(bean.data.datas);
        } else {
          if (_list.length == 0) {
            state = 0;
          }
        }
      });
    });
  }


  Future<Null> _refreshData() async {
    _mPage = 0;
    await widget.getList(false, context, _mPage, (t) {
      NewListProjectBean bean = t;

      setState(() {
        if (bean.data.datas.length > 0) {
          pageCount = bean.data.pageCount;
          _list.clear();
          _list.addAll(bean.data.datas);
        } else {
          if (_list.length == 0) {
            state = 0;
          }
        }
      });
    });
  }

  Widget _onRefresh() {
    return new RefreshIndicator(
        key: _refresh,
        child: _getListView(),
        onRefresh: _refreshData);
  }


  Widget _getListView() {
    return new ListView.builder(
      itemCount: _list.length + 1,
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      itemBuilder: (buildContext, position) {
        return position < _list.length ?  ChaptersWidget(_list[position],context): _list.length < 10 ? new Container() : _mPage < pageCount
            ? LoadingMoreToast()
            : LoadingFinishToast();
      },
      controller: _scrollController,
    );
  }


  Widget _getListItem(ChaptersDatasBean bean) {
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
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
      ),onTap: (){
      pushWidget(context, new WebViewPage(bean.title, bean.link), false);

    },
    );
  }


}