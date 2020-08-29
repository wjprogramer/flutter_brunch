import 'package:flutter/material.dart';
import 'package:flutter_brunch/brunch_0725/firefly_demo_5.dart';
import 'package:flutter_brunch/brunch_0829/ui/flutter_brunch_challenge_app.dart';
import 'package:flutter_brunch/shared/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var screensOf = <String, Widget>{
    '0725 Brunch': FireFlyDemo5(),
    '0829 FlutterBrunchChallengeApp': FlutterBrunchChallengeApp(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Brunch'),),
      body: ListView(
        children: screensOf.entries.map((e) => button(
          context: context,
          text: e.key,
          page: e.value,
        )).toList(),
      ),
    );
  }
}
