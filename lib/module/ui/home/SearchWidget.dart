import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_go/module/base/BaseBean.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';
import 'package:flutter_go/module/base/widget/LoadingFinishToast.dart';
import 'package:flutter_go/module/base/widget/LoadingMoreToast.dart';
import 'package:flutter_go/module/base/widget/SearchTextField.dart';
import 'package:flutter_go/module/base/widget/SearchTitleField.dart';
import 'package:flutter_go/module/base/widget/WebViewPage.dart';
import 'package:flutter_go/module/http/HttpHelper.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_go/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ApiConfig.dart';
import 'bean/ChaptersDatasBean.dart';
import 'bean/ChaptersListBean.dart';

/**
 * Created by Amuser
 * Date:2019/8/26.
 * Desc:搜索
 */
class SearchWidget extends BaseFulWidget {
  String _context;
  SearchWidget(this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new SearchState("搜索");
  }
  search(bool isLoad, BuildContext context,int page, FormData map,
      callBack(t)) async {
    var response = await HttpHelper().requestPost(
        context, isLoad, ApiConfig.GO_SEARCH_LIST+ page.toString()+"/json", data: map);
    filtration(isLoad, context, response, (t) {
      callBack(ChaptersListBean.fromJson(t));
    });
  }

}

class SearchState extends BaseWidget<SearchWidget> {
  SearchState(String titles) : super(titles);

  List<ChaptersDatasBean> _list = new List();
  int state = 1;
  int _mPage = 0;
  int pageCount = 0;
  final TextEditingController etControllerSearch = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refresh = new GlobalKey<
      RefreshIndicatorState>();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Scaffold(
      body: new Column(
        children: <Widget>[
          new SearchTitleField(
            Icons: Icons.keyboard_arrow_left,
            controller: etControllerSearch,
            hintContent: "请输入搜索内容",
            submitText: (text){
              _refreshData();
            },
            onLeftBack: (){
              closeWidget();
            },
          ),
          new Expanded(child:  setBodyWidget(context)),
        ],
      ),
    );
  }

  Widget setBodyWidget(BuildContext buildContext) {
    // TODO: implement setWidget
    return state == 0 ? setEmptyPage() : _onRefresh();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      etControllerSearch.text=widget._context;
    });

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
    await widget.search(page > 0 ? false : true, context, page,_getFrom(), (t) {
      ChaptersListBean bean = t;
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
    _mPage=0;
    await widget.search(false, context, _mPage,_getFrom(), (t) {
      ChaptersListBean bean = t;

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

  FormData _getFrom(){
    return new FormData.from({
      "k": "${etControllerSearch.text.trim()}",
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
      itemCount: _list.length+1,
      padding: EdgeInsets.all(0),
      itemBuilder: (buildContext, position) {
        return position < _list.length ? new Container(
          child: _getListItem(_list[position]),
          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
        ) : _list.length <10?new Container(): _mPage < pageCount ? LoadingMoreToast()
            : LoadingFinishToast();
      }, controller: _scrollController,
    );
  }


  Widget _getListItem(ChaptersDatasBean bean) {
    return new GestureDetector(
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
      onTap: (){
        pushWidget(context, new WebViewPage(bean.title, bean.link), false);
      },
    );
  }


}