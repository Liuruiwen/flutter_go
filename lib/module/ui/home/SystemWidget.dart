import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseStateWidget.dart';
import 'package:flutter_go/module/base/widget/ChipsTitle.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';
import 'package:flutter_go/module/http/HttpHelper.dart';
import 'package:flutter_go/module/ui/system/ArticleListWidget.dart';
import 'package:flutter_go/module/ui/system/bean/ChildrenDataBean.dart';
import 'package:flutter_go/module/ui/system/bean/CodeSystemBean.dart';
import 'package:flutter_go/module/ui/system/bean/SystemDataBean.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_go/res/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ApiConfig.dart';

/**
 * Created by Amuser
 * Date:2019/8/2.
 * Desc:知识体系
 */
class SystemWidget extends BaseFulWidget {
  BuildContext context;

  SystemWidget(this.context);

  @override
  SystemState createState() {
    // TODO: implement createState
    return new SystemState();
  }

  treeList(bool isLoad, BuildContext context, int page, callBack(t)) async {
    var response = await HttpHelper().requestGet(
        context, isLoad,
        ApiConfig.GO_TREE_JSON);
    filtration(isLoad, context, response, (t) {
      callBack(CodeSystemBean.fromJson(t));
    });
  }


}

class SystemState extends BaseStateWidget<SystemWidget>
    with AutomaticKeepAliveClientMixin {
  List<ChildrenDataBean> _listChildren = new List();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    screen(context);
    return new Scaffold(
        body: _listChildren.length>0?_getListView():new Center(child: new Text("什么鬼"),));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _getData());
  }

  _getData() async {
    await widget.treeList(true,widget.context, 1, (t) {
      CodeSystemBean bean = t;
      setState(() {
        _listChildren.addAll(bean.data);
      });
    });
  }



  Widget _getListView() {
    return new ListView.builder(
      itemCount: _listChildren.length,
      itemBuilder: (buildContext, position) {
        return  _getListItem( _listChildren[position]);
      },
    );
  }



  Widget _getListItem(ChildrenDataBean bean){
    final List<Widget> chips =bean.children.map<Widget>((SystemDataBean _model) {
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
          pushWidget(widget.context, new ArticleListWidget(_model.name,_model.id.toString()), false) ;
        },
      );
    }).toList();
    return new ChipsTitle(
        label: bean.name,
        children: chips,
      );
  }


}




