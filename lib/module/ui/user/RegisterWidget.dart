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
import 'package:flutter_go/res/styles.dart';
import 'package:flutter_go/module/ui/user/bean/LoginBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Common.dart';
import '../../ApiConfig.dart';
import '../HomeWidget.dart';

/**
 * Created by Amuser
 * Date:2019/8/1.
 * Desc:注册
 */

class RegisterWidget extends BaseFulWidget {
  @override
  RegisterState createState() {
    return new RegisterState();
  }

  _register(bool isLoad, BuildContext context, FormData map, callBack(t)) async {
    var response = await HttpHelper().requestPost(
        context, isLoad, ApiConfig.GO_RESISTER, data: map);
    filtration(isLoad, context, response, (t) {
      callBack(LoginBean.fromJson(t));
    });
  }

}

class RegisterState extends BaseWidget<RegisterWidget> {
  RegisterState() : super("注册");

  final TextEditingController etControllerUser = TextEditingController();
  final TextEditingController etControllerUserPwd = TextEditingController();
  final TextEditingController etControllerUserAgainPwd = TextEditingController();


  String imageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564642904714&di=26df17fb81e73b835aa26f78878af8be&imgtype=0&src=http%3A%2F%2Fimg1.mukewang.com%2F5c18cf540001ac8206000338.jpg";

  @override
  Widget setWidget(BuildContext buildContext) {
    // TODO: implement setWidget
    return _getListBody();
  }

  Widget _getListBody() {
    return new ListView(

      children: <Widget>[
        new Center(
          child:  new CircleImage(
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
            hintContent: "请输入新密码",
            hasSuffixIcon: true
        ),
        new ItemTextField(
            controller: etControllerUserAgainPwd,
            prefixIcon: Icons.lock,
            hintContent: "请确认新密码",
            hasSuffixIcon: true
        ),
        Gaps.vGap15,
        new RoundButton(textContent: "注册", buttonClick: () {
          _processRegister(context);
        }, margin: EdgeInsets.fromLTRB(30, 10, 30, 30),),
      ],
    );
  }





  _processRegister(BuildContext buildContext) async {
    if ("${etControllerUser.text.trim()}" == "") {
      showToast("用户名不能为空");
      return;
    }
    if ("${etControllerUserPwd.text.trim()}" == "") {
      showToast("密码不能为空");
      return;
    }
    if ("${etControllerUserAgainPwd.text.trim()}" == "") {
      showToast("请输入确认密码");
      return;
    }
    if("${etControllerUserAgainPwd.text.trim()}" != "${etControllerUserPwd.text.trim()}"){
      showToast("两次密码输入不一致");
      return;
    }


    await widget._register(true, buildContext,
        new FormData.from({
          "username": "${etControllerUser.text.trim()}",
          "password": "${etControllerUserPwd.text.trim()}",
          "repassword": "${etControllerUserAgainPwd.text.trim()}",
        }), (t) {
          LoginBean loginBean = t;
          String jsonStr = jsonEncode(loginBean);
          _spUserData(loginBean.data.nickname,jsonStr);
          print("经过了这里？？");
          closeForWidget(new ResultCode(loginBean.data.nickname,"true"));
        });
  }


  _spUserData(String userName,String json) async{
    SharedPreferences spUser = await SharedPreferences.getInstance();
    spUser.setString(Common.SP_LOGIN_USER_NAME,userName);
    spUser.setBool(Common.SP_LOGIN_USER_IS_LOGIN, true);
    spUser.setString(Common.SP_LOGIN_USER_DETAIL, json);
  }
}