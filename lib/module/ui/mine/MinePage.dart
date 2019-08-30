import 'package:flutter/material.dart';
import 'package:flutter_go/module/base/BaseFulWidget.dart';
import 'package:flutter_go/module/base/BaseStateWidget.dart';
import 'package:flutter_go/module/base/widget/CircleImage.dart';
import 'package:flutter_go/module/base/widget/LineWidget.dart';
import 'package:flutter_go/module/ui/user/LoginWidget.dart';
import 'package:flutter_go/module/ui/mine/UserInfoWidget.dart';
import 'package:flutter_go/res/Colours.dart';
import 'package:flutter_go/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Common.dart';
import 'AboutWeWidget.dart';

/**
 * Created by Amuser
 * Date:2019/8/2.
 * Desc:个人中心
 */
class MinePage extends BaseFulWidget {
  BuildContext context;

  MinePage(this.context);

  @override
  MinePageState createState() {
    // TODO: implement createState
    return new MinePageState();
  }

}

class MinePageState extends BaseStateWidget<MinePage> with AutomaticKeepAliveClientMixin {
  String _imgUrl = "";
  String _name = "请先登录";
  bool isTrue;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    screen(context);
    return new Scaffold(
        body: _getListView()
    );
  }
  
  Widget _getListView(){
    return new ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        _getHead(),
        _getItem("个人简介", () {
          isTrue
              ? pushWidget(widget.context, new UserInfoWidget(), false)
              : _loginOut();
        }),
        new LineWidget(),
        _getItem("分享", () {
          showToast("此功能正在开发中");
        }),
        new LineWidget(),
        _getItem("关于我", () {
          pushWidget(widget.context, new AboutWeWidget(), false);
        }),
        new LineWidget(),
        isTrue == false || isTrue==null? new Container() : _getItem("退出登录", () {
          _loginOut();
        }),
        new LineWidget(),

      ],
    );
  }


  Widget _getHead() {
    return new Stack(
      alignment: new Alignment(0, 0),
      children: <Widget>[
        new Image(image: new AssetImage('image/mine_head.jpg'),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: ScreenUtil.getInstance().setHeight(Dimens.go_i_dp400),
          fit: BoxFit.cover,
        ),
        new GestureDetector(
          child: new Column(
            children: <Widget>[
              new CircleImage(
                url: _imgUrl,
                circleHeight: Dimens.go_i_dp150,
                circleWidth: Dimens.go_i_dp150,
              ),
              new Container(
                child: new Text("$_name"),
                margin: EdgeInsets.only(top: getWidth(Dimens.go_i_dp10)),
              )
            ],
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () {
            isLogin();
          },
        ),


      ],
    );
  }


  Widget _getItem(String content, Function tap) {
    return new Container(
      child: new GestureDetector(
        child: new Row(
          children: <Widget>[
            new Expanded(child: new Text(content)),
            new Icon(Icons.keyboard_arrow_right, color: Colours.gray_cc,)
          ],
        ),
        onTap: tap,
      ),
      padding: EdgeInsets.all(getWidth(30)),
    );
  }


  isLogin() async {
    if (isTrue == false) {
      final result = await Navigator.push( //等待
         widget.context,
          MaterialPageRoute(builder: (context) => new LoginWidget()));
      setState(() {
        if (result != null && "${result.isLogin}" == "true") {
          isTrue = true;
          _imgUrl =
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564986366401&di=121f4c1eaff51dbfe1b7c11c727ad7c2&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201703%2F17%2F20170317164407_wiZny.thumb.700_0.jpeg";
          _name = "${result.userName}";
        }
      });

//        //这是在页面底部显示一个弹出提示
//        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('${result.userName}'+'      '+'${result.isLogin}')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _processLogin();
  }



  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  _processLogin() async {
    SharedPreferences spUser = await SharedPreferences.getInstance();
    isTrue = spUser.getBool(Common.SP_LOGIN_USER_IS_LOGIN) ?? false;
    if (isTrue) {
      setState(() {
        _name = spUser.getString(Common.SP_LOGIN_USER_NAME);
        _imgUrl =
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564986366401&di=121f4c1eaff51dbfe1b7c11c727ad7c2&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201703%2F17%2F20170317164407_wiZny.thumb.700_0.jpeg";
      });
    }
  }

  _loginOut() async {
    isTrue = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(Common.SP_LOGIN_USER_IS_LOGIN);
    setState(() {
      _name = "请先登录";
      _imgUrl = "";
    });
    isLogin();
  }


}