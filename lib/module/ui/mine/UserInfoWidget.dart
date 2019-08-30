import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseWidget.dart';
import 'package:flutter_go/module/base/widget/CircleImage.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';
import 'package:flutter_go/module/ui/user/bean/LoginBean.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../../../Common.dart';
import 'package:flutter_go/res/Dimens.dart';

/**
 * Created by Amuser
 * Date:2019/8/6.
 * Desc:用户信息
 */
class UserInfoWidget extends BaseFulWidget {
  @override
  UserInfoState createState() {
    // TODO: implement createState
    return new UserInfoState();
  }

}

class UserInfoState extends BaseWidget<UserInfoWidget> {
  UserInfoState() : super("个人简介");
  LoginBean _login;

  @override
  Widget setWidget(BuildContext buildContext) {
    // TODO: implement setWidget

    return _login == null
        ? new Center(child: new Text("数据为空哦"),)
        : _getListWidget();
  }

  @override
  void initState() {
    super.initState();
    _spUserData();
  }
  _spUserData() async {
    SharedPreferences spUser = await SharedPreferences.getInstance();
    String json = spUser.getString(Common.SP_LOGIN_USER_DETAIL) ?? "";
    print(json);
    if (json != "") {
      String imgUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564986366401&di=121f4c1eaff51dbfe1b7c11c727ad7c2&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201703%2F17%2F20170317164407_wiZny.thumb.700_0.jpeg";
      Map<String, dynamic> user = convert.jsonDecode(json);
      setState(() {
        _login = LoginBean.fromJson(user);
        _login.data.icon = imgUrl;
      });
    }
  }

  Widget _getListWidget() {
    return new ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        new Center(
          child: new CircleImage(
              url: _login.data.icon,
              circleHeight: Dimens.go_i_dp150,
              circleWidth: Dimens.go_i_dp150,
              margin: EdgeInsets.all(30)
          ),
        ),
        new LineWidget(),
        _getItem("昵称：" + _login.data.nickname),
        new LineWidget(),
        _getItem("Id：" + _login.data.id.toString()),
        new LineWidget(),
        _getItem("类型：" + _login.data.type.toString()),
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