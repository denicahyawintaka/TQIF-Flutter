import 'package:diary_app/screen/DiaryPage.dart';
import 'package:diary_app/screen/DiaryViewPage.dart';
import 'package:diary_app/screen/HomePage.dart';
import 'package:diary_app/screen/SelectDiaryPage.dart';
import 'package:diary_app/screen/SelectMoodPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
