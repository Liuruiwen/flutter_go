import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/ui/system/SystemPage.dart';
import 'home/BannerWidget.dart';
import 'home/HomePage.dart';
import 'package:flutter_go/module/ui/mine/MinePage.dart';

/**
 * Created by Amuser
 * Date:2019/7/25.
 * Desc:首页
 */

class HomeWidget extends StatefulWidget {
  BuildContext context;

  HomeWidget(this.context);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<HomeWidget> {
  int _currentIndex;
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController(initialPage: _currentIndex);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body:_getPageView(),
//    _pages==null?new Container() :PageView.builder(
//        physics: NeverScrollableScrollPhysics(),//viewPage禁止左右滑动
//        onPageChanged: _pageChange,
//        controller: _controller,
//        itemCount: _pages.length,
//        itemBuilder: (context, index) => _pages[index]),
    bottomNavigationBar: BottomNavigationBar(
      items: getItems(),
      currentIndex: _currentIndex,
      onTap: onTap,
    ),
  );



  Widget _getPageView(){
    return new PageView(
      physics: NeverScrollableScrollPhysics(),//viewPage禁止左右滑动
      onPageChanged: _pageChange,
      controller: _controller,
        children: <Widget>[
      new Offstage(
        offstage: _currentIndex != 0,
        child: new TickerMode(
          enabled: _currentIndex == 0,
          child: new MaterialApp(
            home: new HomePage(context),
          ),
        ),
      ),
      new Offstage(
        offstage: _currentIndex != 1,
        child: new TickerMode(
          enabled: _currentIndex == 1,
          child: new MaterialApp(
            home: new SystemPage(context),
          ),
        ),
      ),
      new Offstage(
        offstage: _currentIndex != 2,
        child: new TickerMode(
          enabled: _currentIndex == 2,
          child: new MaterialApp(
            home: new MinePage(context),
          ),
        ),
      ),
    ],);
  }
  List<BottomNavigationBarItem> getItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
      BottomNavigationBarItem(icon: Icon(Icons.collections), title: Text("学识")),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的"))
    ];
  }


  Widget _getItemWidget(Widget widget){
    return MaterialApp(
      home: widget,
    );
  }

  void onTap(int index) {
    _controller.jumpToPage(index);
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
//        print("==="+index.toString());
        _currentIndex = index;
      });
    }
  }
}