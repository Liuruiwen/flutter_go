import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'WelcomeWidget.dart';



void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterGo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:new WelcomeWidget());
  }
}

