import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseWidget.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';

/**
 * Created by Amuser
 * Date:2019/8/6.
 * Desc:关于我们
 */

class AboutWeWidget extends BaseFulWidget {
  @override
  AboutWeState createState() {
    // TODO: implement createState
    return new AboutWeState();
  }

}

class AboutWeState extends BaseWidget<AboutWeWidget> {
  AboutWeState() : super("关于我们");

  @override
  Widget setWidget(BuildContext buildContext) {
    // TODO: implement setWidget
    return  new ListView(
      padding: EdgeInsets.all(0),
        children: <Widget>[
          _getItem("程序员：Amuser"),
          new LineWidget(),
          _getItem("交流群：478720016"),
          new LineWidget(),
          _getItem("QQ：3329443930"),
          new LineWidget(),
          _getItem("个人感慨：一入吾门深似海，两眼忘川世间情！"),
          new LineWidget(),
        ],
      );
  }

  Widget _getItem(String content) {
    return new Container(
      child: new Text(content),
      padding: EdgeInsets.all(getWidth(30)),
    );
  }
}