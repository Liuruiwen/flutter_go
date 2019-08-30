import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../BaseFulWidget.dart';
import '../BaseWidget.dart';

/**
 * Created by Amuser
 * Date:2019/8/8.
 * Desc:加载Html页面
 */

class WebViewPage extends BaseFulWidget {
  String _title;
  final String _url;

  WebViewPage(this._title, this._url);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new WebViewPageState(_title);
  }

}

/**
 *
 * const WebviewScaffold({
    Key key,
    this.appBar,
    @required this.url,//String 加载的URL
    this.headers,//添加头部
    this.withJavascript,//bool 是否开启Javascript
    this.clearCache,//bool 清理缓存
    this.clearCookies,//bool 清理cookies
    this.enableAppScheme,//
    this.userAgent,//String userAgent
    this.primary = true,
    this.persistentFooterButtons,
    this.bottomNavigationBar,//Widget 底部的bar
    this.withZoom,//bool 是否允许缩放
    this.withLocalStorage,//bool 是否开启本地缓存
    this.withLocalUrl,//bool
    this.scrollBar,//bool 是否显示scrollBar
    this.supportMultipleWindows,
    this.appCacheEnabled,//bool 是否开启缓存
    this.hidden = false,//bool 是否隐藏
    this.initialChild,//初始化的child,如果hidden = true 显示Widget
    this.allowFileURLs,//bool 是否允许请求本地的FileURL
    this.resizeToAvoidBottomInset = false,
    this.invalidUrlRegex,
    this.geolocationEnabled


    上述我们可以将一个Web加载出来了,如果想要监听Web的状态,就需要用到FlutterWebviewPlugin来设置监听.

    FlutterWebviewPlugin WebView的状态监听
    //监听URL的改变
    StreamSubscription<String> _onUrlChanged;
    //监听WebView的状态改变
    StreamSubscription<WebViewStateChanged> _onStateChanged;
    //监听WebView的错误状态
    StreamSubscription<WebViewHttpError> _onHttpError;

    webviewReference.close(); //关闭页面 防止重新打开
    //URL 改变的监听
    _onUrlChanged = webviewReference.onUrlChanged.listen((url) {});

    //监听加载状态
    _onStateChanged = webviewReference.onStateChanged.listen((state) {
    switch (state.type) {
    case WebViewState.startLoad: //开始加载
    if (_isToMain(state.url) && !exiting) {
    if (widget.backForbid) {
    webviewReference.launch(widget.url);
    } else {
    Navigator.pop(context);
    exiting = true;
    }
    }
    break;
    default:
    break;
    }
    });

    //监听错误状态
    _onHttpError = webviewReference.onHttpError.listen((error) {
    print(error);
    });
    需要注意的是,在Widget销毁之前将WebView的监听和view销毁掉.

    @override
    void dispose() {
    //销毁web view
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
    }


    文章作者: JakePrim

    文章链接: https://jakeprim.cn/2019/04/07/flutter-1-3/

    版权声明: 本博客所有文章除特别声明外，均采用 CC BY-NC-SA 4.0 许可协议。转载请注明来自 JakePrim技术研究院！


 */

class WebViewPageState extends BaseWidget<WebViewPage> {
  WebViewPageState(String title) : super(title);
  final webviewReference = new FlutterWebviewPlugin();

//监听URL的改变
  StreamSubscription<String> _onUrlChanged;

//监听WebView的状态改变
  StreamSubscription<WebViewStateChanged> _onStateChanged;

//监听WebView的错误状态
  StreamSubscription<WebViewHttpError> _onHttpError;

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  _getWebView();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    webviewReference.close(); //关闭页面 防止重新打开
    //URL 改变的监听
    _onUrlChanged = webviewReference.onUrlChanged.listen((url) {

    });

    //监听加载状态
    _onStateChanged = webviewReference.onStateChanged.listen((state) {
      switch (state.type) {
        case WebViewState.shouldStart:
          // TODO: Handle this case.
          break;
        case WebViewState.startLoad:
          // TODO: Handle this case.
          break;
        case WebViewState.finishLoad:
          // TODO: Handle this case.
          break;
//        case WebViewState.abortLoad:
//          // TODO: Handle this case.
//          break;
      }
    });
    //监听错误状态
    _onHttpError = webviewReference.onHttpError.listen((error) {
      print(error);
    });
  }



//  @override
//  Widget setWidget(BuildContext buildContext) {
//    // TODO: implement setWidget
//    return _getWebView();
//  }

  Widget _getWebView() {
    return new WebviewScaffold(
      appBar: new AppBar(
        title: Container(child: new Center(child: new Text(widget._title, textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,)),
          width: 200,
        ),
        centerTitle: true,
        leading: new GestureDetector(
          child: new Icon(Icons.keyboard_arrow_left),
          onTap: (){
            closeWidget();
          },
        ),
      ),
      url: widget._url,
      //加载的URL
      withZoom: true,
      //允许缩放
      withLocalStorage: true,
//      hidden: true,
      //默认状态隐藏
//      initialChild: Container(
//        color: Colors.white,
//        child: Center(
//          child: Text('Wiating...'),
//        ),
//      ), //设置初始化界面
    );
  }

  @override
  void dispose() {
    //销毁web view
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

}