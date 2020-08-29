import 'package:flutter/material.dart';
import 'home/home_screen.dart';

class FlutterBrunchChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Brunch Challenge',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: HomeScreen(),
//    );
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      child: HomeScreen(),
    );
  }
}

