import 'package:flutter/material.dart';
import 'home/home_screen.dart';

class FlutterBrunchChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      child: HomeScreen(),
    );
  }
}

