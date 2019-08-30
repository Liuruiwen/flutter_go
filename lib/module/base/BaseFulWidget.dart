
//import 'dart:convert';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go/module/dialog/DialogWidget.dart';
import 'package:flutter_go/module/http/HttpHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'BaseBean.dart';


/**
 * Created :Auser
 *  Date: 2019/5/6.
 *  Desc:widget基类
 */
abstract class BaseFulWidget  extends StatefulWidget {

 filtration(bool isLoad,BuildContext context,Response response,callBack(t)){
   isLoadingDialog(isLoad, context);
   if(response.statusCode==200){
     BaseBean bean = BaseBean.fromJson(response.data);
     switch (bean.errorCode) {
       case 0:
         callBack(response.data);
         break;
       default:
         showToast(bean.errorMsg);
         break;
     }
   }else {
     callBack(null);
   }

 }



 void isLoadingDialog(bool isLoad,BuildContext context){
   if(isLoad){
     Navigator.of(context).pop();
   }
 }



 void showToast(String msg){
   Fluttertoast.showToast(
       msg: msg,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.CENTER,
       timeInSecForIos: 1,
       backgroundColor: Colors.blue,
       textColor: Colors.white);
 }


}


