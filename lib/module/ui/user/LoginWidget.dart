import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/widget/CircleImage.dart';
import 'package:flutter_go/module/base/widget/ItemTextField.dart';
import 'package:flutter_go/module/base/widget/RoundButton.dart';
import 'package:flutter_go/module/http/HttpHelper.dart';
import 'package:flutter_go/module/ui/bean/ResultCode.dart';
import 'package:flutter_go/res/strings.dart';
import 'package:flutter_go/res/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_go/module/ui/user/bean/LoginBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Common.dart';
import '../../ApiConfig.dart';
import 'RegisterWidget.dart';
/**
 * Created by Amuser
 * Date:2019/7/26.
 * Desc:登录页面
 */

class LoginWidget extends BaseFulWidget {

  @override
  LoginState createState() {
    return new LoginState();
  }

  login(bool isLoad, BuildContext context, FormData map,
       callBack(t)) async {
    var response = await HttpHelper().requestPost(
        context, isLoad, ApiConfig.GO_LOGIN, data: map);
    filtration(isLoad, context, response, (t) {
      callBack(LoginBean.fromJson(t));
    });
  }

}

class LoginState extends BaseWidget<LoginWidget> {
  LoginState() : super("登录");

  final TextEditingController etControllerUser = TextEditingController();
  final TextEditingController etControllerUserPwd = TextEditingController();


  String imageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564642904714&di=26df17fb81e73b835aa26f78878af8be&imgtype=0&src=http%3A%2F%2Fimg1.mukewang.com%2F5c18cf540001ac8206000338.jpg";


  @override
  Widget setWidget(BuildContext buildContext) {
    // TODO: implement setWidget
    return _getListBody();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserName();
  }

  void _getUserName() async {
    SharedPreferences spUser = await SharedPreferences.getInstance();
    String name = spUser.getString(Common.SP_LOGIN_USER_NAME) ?? "";
    if (name != "") {
      String _name = spUser.getString(Common.SP_LOGIN_USER_NAME);
      etControllerUser.text = _name;
    }
  }


  Widget _getListBody() {
    return new ListView(
      children: <Widget>[
        new Center(
          child: new CircleImage(
            url: imageUrl,
            circleHeight: 200,
            circleWidth: 200,
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
          ),
        ),
        new ItemTextField(
          controller: etControllerUser,
          prefixIcon: Icons.person,
          hintContent: "请输入用户名",
          margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
        ),
        Gaps.vGap15,
        new ItemTextField(
            controller: etControllerUserPwd,
            prefixIcon: Icons.lock,
            hintContent: "请输入密码",
            hasSuffixIcon: true
        ),
        Gaps.vGap15,
        new RoundButton(textContent: "登录", buttonClick: () {
          _processLogin(context);
        }, margin: EdgeInsets.fromLTRB(30, 10, 30, 0),),
        new Container(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Text("亲，注册了？"),
              new GestureDetector(
                child: new Text("注册", style: TextStyle(color: Colors.blue,
                    fontSize: ScreenUtil.getInstance().setSp(30)),),
                onTap: () {
                  _register();
                },
              )
            ],
          ),
          margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
        )
      ],
    );
  }

  _processLogin(BuildContext buildContext) async {
    if ("${etControllerUser.text.trim()}" == "") {
      showToast("用户名不能为空");
      return;
    }
    if ("${etControllerUserPwd.text.trim()}" == "") {
      showToast("密码不能为空");
      return;
    }

    await widget.login(true, buildContext,
        new FormData.from({
          "username": "${etControllerUser.text.trim()}",
          "password": "${etControllerUserPwd.text.trim()}",
        }), (t) {
          LoginBean loginBean = t;
          String jsonStr = jsonEncode(loginBean); //实体类转josn方法
          _spUserData(loginBean.data.nickname, jsonStr);
          closeForWidget(new ResultCode(loginBean.data.nickname, "true"));
        });
  }

  _spUserData(String userName, String json) async {
    SharedPreferences spUser = await SharedPreferences.getInstance();
    spUser.setString(Common.SP_LOGIN_USER_NAME, userName);
    spUser.setBool(Common.SP_LOGIN_USER_IS_LOGIN, true);
    spUser.setString(Common.SP_LOGIN_USER_DETAIL, json);
  }


  void _register() async {
    final result = await pushForWidget(context, new RegisterWidget());
    setState(() {
      if (result != null && "${result.isLogin}" == "true") {
        closeForWidget(new ResultCode("${result.userName}", "true"));
      }
    });
  }


}