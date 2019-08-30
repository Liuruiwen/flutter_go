import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_go/module/dialog/DialogWidget.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import '../../Common.dart';

/**
 * Created :Auser
 *  Date: 2019/5/7.
 *  Desc:http请求工具类
 *  https://www.jianshu.com/p/1352351c7d08   dio详解
 */
class HttpHelper {
  static const GET = "GET";
  static const POST = "POST";
  static const baseUrl = Common.BASE_URL;
  static Dio _dio;
  PersistCookieJar _cookieJar;

  ///Cookie持久化
  HttpHelper._intance() {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
    _initDio();
  }

  static HttpHelper _netUtil;

  factory HttpHelper() {
    return _netUtil ??= HttpHelper._intance();

    ///使用工厂构造函数来实现单例
  }

  void _initDio() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = Directory(join(directory.path, "cookie")).path;
    _cookieJar = PersistCookieJar(dir: path);
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  Future<Response> requestGet(BuildContext context, bool isLoad, url,
      {data, String method = GET}) async {
    try {
      showDialogs(context, isLoad);
      _dio.options.method = method;
      var reponse = await _dio.request(url, data: data);
      print(reponse);
      return reponse;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // post请求封装
  post(url, BuildContext context,bool isLoad, { options, cancelToken, data=null}) async {
    print('post请求::: url：$url ,body: $data');
    var response;

    try{
      showDialogs(context, isLoad);
      response = await _dio.post(
          url,
          data:data !=null ? data : {},
          cancelToken:cancelToken
      );
      print(response);
      return response;
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('get请求取消! ' + e.message);
      }else{
        print('get请求发生错误：$e');
      }
    }
    return null;
  }




  Future<Response> requestPost(BuildContext context, bool isLoad, url,
      {data, String method = POST}) async {
    try {
      showDialogs(context, isLoad);
      _dio.options.method = method;
      Response reponse = await _dio.request(url, data: data);
//      print("====="+reponse.data);
      return reponse;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//  Future<Response> requestPost(BuildContext context, bool isLoad, url,Map<String,Object> data,) async {
//    try {
//      showDialogs(context, isLoad);
////      data.forEach((k,v){
////        print(k+"=="+v.toString());  //类型不一样的时候就toString()
////      });
//
//      var reponse=await _dio.post(url,data:{
//        "username": "RuiWenLiu",
//        "password": "12345678"
//      });
////      var reponse = await _dio.post(url, data: data);
//      print(reponse);
//      return reponse;
//    } catch (e) {
//      print("错误："+e.toString());
//      return null;
//    }
//  }


  showDialogs(BuildContext context, bool isLoad) {
    if (isLoad) {
      showDialog<Null>(
          context: context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new DialogWidget(text: "正在获取详情...");
          });
    }
  }


}