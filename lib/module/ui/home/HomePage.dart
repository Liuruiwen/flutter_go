import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseStateWidget.dart';
import 'package:flutter_go/res/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'BannerWidget.dart';
import 'HotArticleWidget.dart';
import 'SystemWidget.dart';

/**
 * Created by Amuser
 * Date:2019/8/2.
 * Desc:首页
 */
class HomePage extends BaseFulWidget {
  BuildContext context;

  HomePage(this.context);

  @override
  HomePageState createState() {
    // TODO: implement createState
    return new HomePageState();
  }


}

class HomePageState extends BaseStateWidget<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screen(context);
    return _ViewPage();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }


  Widget _ViewPage() {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new TabBar(
            tabs: [
              new Tab(child: new Text(Ids.homeAlerts),),
              new Tab(child: new Text(Ids.homeHot),),
              new Tab(child: new Text("体系"),)
            ],
//            controller: tabController,
            unselectedLabelColor: Colors.white30,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 18),
            unselectedLabelStyle: TextStyle(fontSize: 15),
            indicatorColor: Colors.blue,
          ),
        ),
        body: new TabBarView(
//          controller: tabController,
          children: [
            new BannerWidget(widget.context),
            new HotArticleWidget(widget.context),
            new SystemWidget(widget.context),
          ],
        ),
      )
      ,
    );
  }

}