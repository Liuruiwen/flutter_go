import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'module/base/BaseFulWidget.dart';
import 'module/base/BaseStateWidget.dart';
import 'module/ui/HomeWidget.dart';
import 'module/util/TimerUtil.dart';

/**
 * Created by Amuser
 * Date:2019/7/25.
 * Desc:
 */

class WelcomeWidget extends BaseFulWidget {

  @override
  WelcomeState createState() {
    // TODO: implement createState
    return new WelcomeState();
  }

}

class WelcomeState extends BaseStateWidget<WelcomeWidget> {
  TimerUtil _timerUtil;
  int count = 3;

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
//    _processData(context);
    return Scaffold(
      body: getBodyWidget(),
    );
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _processData(context));
  }

  Widget getBodyWidget() {
    return new Container(
        child: new Stack(children: <Widget>[

          getImage(),
          new Positioned(
            child:new GestureDetector(
              child:  new Container(
                child: new Center(
                    child: Text("$count" + "s",
                      style: new TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    )),
                decoration: new BoxDecoration(
                    color: Colors.blue, shape: BoxShape.circle),
                width: 50,
                height: 50,
              ),onTap: (){
              closePageForWidget(context, new HomeWidget(context));
            },
            ), right: 30, top: 30,)

        ],)
    );
  }

  Widget getImage() {
    return new Image(image: new AssetImage('image/welcome.png'),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fitWidth,
    );
  }


  _processData(BuildContext context) {
    TimerUtil _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        count = _tick.toInt();
      });
      if (_tick == 0) {
        closePageForWidget(context, new HomeWidget(context));
      }
    });
    _timerUtil.startCountDown();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_timerUtil != null) _timerUtil.cancel(); //记得中dispose里面把timer cancel

  }


}
