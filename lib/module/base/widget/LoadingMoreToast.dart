import 'package:flutter/material.dart';

/**
 * Created by Amuser
 * Date:2019/8/28.
 * Desc:加载更多提示
 */

 class LoadingMoreToast extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }

 }