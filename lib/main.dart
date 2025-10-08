import 'dart:convert';

import 'package:covid_data/Screens/Countries_list.dart';
import 'package:covid_data/Screens/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
import 'Screens/Model.dart';
import 'Screens/Url.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen()
    );
  }
}
void main() {
  runApp(MyApp());

}
